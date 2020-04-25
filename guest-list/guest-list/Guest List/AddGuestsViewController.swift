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
        // TODO: Check that requiered fields are filled in 
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
