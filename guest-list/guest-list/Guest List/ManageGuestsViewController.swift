//
//  ManageGuestsViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class ManageGuestsViewController: UIViewController {
    
    // MARK: Properties
    
    private var guestInfoTextFieldsViewController: GuestInfoTextFieldsViewController?
    private var guestStatusViewController: GuestStatusViewController?
    private var moreGuestInfoViewController: MoreGuestInfoViewController?
    var guest: Guest?
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var doneButton: UIButton!
    @IBOutlet weak private var guestInfoContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var guestStatusContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var moreGuestInfoContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var removeGuestButton: LargeStickyButton!
    
    
    // MARK: IBActions

    @IBAction private func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapDoneButton(_ sender: UIButton) {
        addGuestToGuestList()
    }
    
    @IBAction private func didTapRemoveButton(_ sender: LargeStickyButton) {
        handleRemoveGuestButtonTap()
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let viewController = container as? GuestInfoTextFieldsViewController {
            guestInfoContainerHeightConstraint.constant = viewController.preferredContentSize.height
        }
        
        if let viewController = container as? GuestStatusViewController {
            guestStatusContainerHeightConstraint.constant = viewController.preferredContentSize.height
        }
        
        if let viewController  = container as? MoreGuestInfoViewController {
            moreGuestInfoContainerHeightConstraint.constant = viewController.preferredContentSize.height
        }
    }
    
    private func setup() {
        titleLabel.font = .weddingRegularFont(textSize: .large)
        titleLabel.text = guest == nil ? "Add Guest" : "Update Guest"
        
        cancelButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        
        doneButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        let doneButtonTitle = guest == nil ? "Add" : "Update"
        doneButton.setTitle(doneButtonTitle, for: .normal)
        
        if let guest = guest, guest.id != NetworkManager.shared.getUserId() {
            // Executed if there is a guest. Except from if the guest is the logged in user. User can't delete itself from the guest list.
            removeGuestButton.colorScheme = .whiteOnRed
            removeGuestButton.setTitle("Remove \(guest.firstname)", for: .normal)
        } else {
            removeGuestButton.isHidden = true
        }
        
        scrollView.keyboardDismissMode = .interactive
        
        // Children
        
        guard let guestInfoTextFieldsViewController = children.first(where: { (viewController) -> Bool in
            return viewController.restorationIdentifier == "GuestInfoTextFieldsViewController"
        }) as? GuestInfoTextFieldsViewController else {
            fatalError("Check storyboard for missing GuestInfoTextFieldsViewController")
        }
        
        guard let guestStatusViewController = children.first(where: { (viewController) -> Bool in
            return viewController.restorationIdentifier == "GuestStatusViewController"
        }) as? GuestStatusViewController else {
            fatalError("Check storyboard for missing GuestStatusViewController")
        }
        
        guard let moreGuestInfoViewController = children.first(where: { (viewController) -> Bool in
            return viewController.restorationIdentifier == "MoreGuestInfoViewController"
        }) as? MoreGuestInfoViewController else {
            fatalError("Check storyboard for missing MoreGuestInfoViewController")
        }
                
        self.guestInfoTextFieldsViewController = guestInfoTextFieldsViewController
        self.guestStatusViewController = guestStatusViewController
        self.moreGuestInfoViewController = moreGuestInfoViewController
        
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Executed if user already exists and are about to be updated
        if let guest = self.guest {
            if segue.identifier == "guestInfoSeque" {
                let child = segue.destination as! GuestInfoTextFieldsViewController
                child.firstname = guest.firstname
                child.lastname = guest.lastname
                child.email = guest.email
            } else if segue.identifier == "guestStatusSegue" {
                let child = segue.destination as! GuestStatusViewController
                child.rsvp = guest.rsvp
                child.list = guest.list
                child.role = guest.role
                child.relation = guest.relation
                child.familyStatus = guest.familyStatus
                child.gender = guest.gender
            } else if segue.identifier == "moreGuestInfoSegue" {
                let child = segue.destination as! MoreGuestInfoViewController
                child.address = guest.address
                child.phoneNumber = guest.phoneNumber
                child.allergies = guest.allergies
                child.disabilities = guest.disabilities
                child.transport = guest.transport
                child.notes = guest.notes
                child.invitationSent = guest.invitationSent
                child.thankYouSent = guest.thankYouSent
            }
        }
    }
    
    private func addGuestToGuestList() {
        guard let (firstname, lastname, email) = guestInfoTextFieldsViewController?.getGuestInfo() else { return }
        let (rsvp, list, role, relation, familyStatus, gender) = guestStatusViewController!.getGuestInfo()
        let (address, phoneNumber, allergies, disabilities, transport, notes, invitationSent, thankYouSent) = moreGuestInfoViewController!.getGuestInfo()
        
        var guest: Guest {
            if var existingGuest = self.guest {
                // Update already existing guest
                existingGuest.update(firstname, lastname, email, address, phoneNumber, allergies, disabilities, transport, notes, rsvp, list, role, relation, familyStatus, gender, invitationSent, thankYouSent)
                return existingGuest
            } else {
                // Create new guest
                let uid = UUID().uuidString
                let newGuest = Guest(uid, firstname, lastname, email, address, phoneNumber, allergies, disabilities, transport, notes, rsvp, list, role, relation, familyStatus, gender, invitationSent, thankYouSent)
                return newGuest
            }
        }
        
        NetworkManager.shared.updateGuestList(with: guest) { (error) in
            if let error = error {
                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            NotificationCenter.default.post(name: .GuestListDidChange, object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func handleRemoveGuestButtonTap() {
        guard let guest = guest else { return }
        let alert = UIAlertController(title: "", message: "Are you sure you want to remove \(guest.firstname) from the event?", preferredStyle: .alert)
        alert.view.tintColor = .weddingGray
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in self.remove(guest) }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func remove(_ guest: Guest) {
        NetworkManager.shared.remove(guest) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Couldn't remove guest", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            NotificationCenter.default.post(name: .GuestListDidChange, object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: Keyboard appearance

extension ManageGuestsViewController {
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
}
