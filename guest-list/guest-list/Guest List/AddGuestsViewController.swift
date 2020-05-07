//
//  AddGuestsViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class AddGuestsViewController: UIViewController {
    
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
    
    // MARK: IBActions

    @IBAction private func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapDoneButton(_ sender: UIButton) {
        addGuestToGuestList()
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
        cancelButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        doneButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
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
        
        // Executed if user already exists and are about to be updated
        if let guest = guest {
            guestInfoTextFieldsViewController.firstname = guest.firstname
            guestInfoTextFieldsViewController.lastname = guest.lastname
            guestInfoTextFieldsViewController.email = guest.email
            
            guestStatusViewController.rsvp = guest.rsvp
            guestStatusViewController.list = guest.list
            guestStatusViewController.role = guest.role
            guestStatusViewController.relation = guest.relation
            guestStatusViewController.familyStatus = guest.familyStatus
            guestStatusViewController.gender = guest.gender
            
            moreGuestInfoViewController.address = guest.address
            moreGuestInfoViewController.phoneNumber = guest.phoneNumber
            moreGuestInfoViewController.allergies = guest.allergies
            moreGuestInfoViewController.disabilities = guest.disabilities
            moreGuestInfoViewController.transport = guest.transport
            moreGuestInfoViewController.notes = guest.notes
            moreGuestInfoViewController.invitationSent = guest.invitationSent
            moreGuestInfoViewController.thankYouSent = guest.thankYouSent
        }
        
        self.guestInfoTextFieldsViewController = guestInfoTextFieldsViewController
        self.guestStatusViewController = guestStatusViewController
        self.moreGuestInfoViewController = moreGuestInfoViewController
        
        // Keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: Keyboard appearance

extension AddGuestsViewController {
    
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
