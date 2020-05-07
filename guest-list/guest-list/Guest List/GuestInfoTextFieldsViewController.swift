//
//  GuestInfoTextFieldsViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestInfoTextFieldsViewController: UIViewController {
    
    // MARK: Properties
    
    var firstname: String?
    var lastname: String?
    var email: String?
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var firstnameTextField: LargeTextField!
    @IBOutlet weak private var lastnameTextField: LargeTextField!
    @IBOutlet weak private var emailTextField: LargeTextField!
    
    // MARK: IBAction
    
    @IBAction private func firstnamePrimaryActionTriggered(_ sender: LargeTextField) {
        lastnameTextField.becomeFirstResponder()
    }
    
    @IBAction private func firstnameDidEndEditing(_ sender: LargeTextField) {
        let isValid = firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        firstnameTextField.inputIsValid = isValid
    }
    
    @IBAction private func lastnamePrimaryActionTriggered(_ sender: LargeTextField) {
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction private func emailPrimaryActionTriggered(_ sender: LargeTextField) {
        emailTextField.resignFirstResponder()
    }
    
    @IBAction private func emailDidEndEditing(_ sender: LargeTextField) {
        let isValid = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        emailTextField.inputIsValid = isValid
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    
    private func setup() {
        firstnameTextField.text = firstname
        lastnameTextField.text = lastname
        emailTextField.text = email
    }
    
    // MARK: Accessors
    
    typealias guestFirstname = String
    typealias guestLastname = String?
    typealias guestEmail = String
    func getGuestInfo() -> (guestFirstname, guestLastname, guestEmail)? {
        guard let firstname = firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstname.isEmpty else {
            return nil
        }
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            return nil
        }
        
        var lastname = lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        lastname = lastname == "" ? nil : lastname
        return (firstname, lastname, email)
    }
}
