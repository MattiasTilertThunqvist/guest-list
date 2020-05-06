//
//  SignupWithEmailViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupWithEmailViewController: UIViewController {
        
    // MARK: IBOutlet
    
    @IBOutlet weak private var firstnameTextField: LargeTextField!
    @IBOutlet weak private var lastnameTextField: LargeTextField!
    @IBOutlet weak private var emailTextField: LargeTextField!
    @IBOutlet weak private var passwordTextField: LargeTextField!
    @IBOutlet weak private var signUpButton: LargeStickyButton!
    @IBOutlet private var textfieldsCollection: [LargeTextField]!
    
    // MARK: IBAction
    
    @IBAction private func firstnamePrimaryActionTriggered(_ sender: LargeTextField) {
        lastnameTextField.becomeFirstResponder()
    }
    
    @IBAction private func lastnamePrimaryActionTriggered(_ sender: LargeTextField) {
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction private func emailPrimaryActionTriggered(_ sender: LargeTextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction private func passwordPrimaryActionTriggered(_ sender: LargeTextField) {
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction private func passwordEditingDidEnd(_ sender: LargeTextField) {
        let _ = validPassword()
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateItemsIntoView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.firstnameTextField.becomeFirstResponder()
    }

    private func setUp() {
        navigationItem.title = "SIGN UP"
        
        signUpButton.colorScheme = .email
        signUpButton.setTitle("SIGN UP WITH EMAIL", for: .normal)

        // Place the items outside of the view. When view appears they will be animated to original position.
        let transform = CGAffineTransform.init(translationX: view.frame.width, y: 0)
        signUpButton.transform = transform
        for textfield in textfieldsCollection {
            textfield.transform = transform
        }
    }
    
    private func animateItemsIntoView() {
        var late = Double(0.1)
        let duration = Double(0.2)
        
        for textfield in textfieldsCollection {
            UIView.animate(withDuration: duration, delay: late, options: [], animations: {
                textfield.transform = .identity
                late += 0.1
            })
        }
        
        UIView.animate(withDuration: duration, delay: late, options: [], animations: {
            self.signUpButton.transform = .identity
        })
    }
    
    // MARK: IBAction
    
    @IBAction private func signUpButtonWasPressed(_ sender: LargeStickyButton) {
        resignFirstResponder()
        
        guard let firstname = firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstname.isEmpty else {
            firstnameTextField.inputIsValid = false
            return
        }
        
        var lastname = lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        lastname = lastname == "" ? nil : lastname
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            emailTextField.inputIsValid = false
            return
        }
        
        guard let password = validPassword() else { return }
        createUser(with: email, password, firstname, lastname)    }
    
    // MARK: Helpers
    
    private func validPassword() -> String? {
        let minimumCharacters = 6
        
        if let passwordInput = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                passwordInput.count >= minimumCharacters {
            passwordTextField.inputIsValid = true
            passwordTextField.placeholder = "Password*"
            return passwordInput
        } else {
            passwordTextField.inputIsValid = false
            passwordTextField.placeholder = "Minimum 6 characters required"
            return nil
        }
    }
    
    private func createUser(with email : String, _ password: String, _ firstname: String, _ lastname: String?) {
        NetworkManager.shared.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                let alert = UIAlertController(title: "Could not create account", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
                
            self.addNewUserToGuestList(user!.uid, firstname, lastname, email)
        }
    }
    
    private func addNewUserToGuestList(_ uid: String, _ firstname: String, _ lastname: String?, _ email: String) {
        let guest = Guest(uid, firstname, lastname, email, nil, nil, nil, nil, nil, nil, .attending, .guestList, .weddingCouple, .family, .relationship, .other, false, false)
        NetworkManager.shared.updateGuestList(with: guest) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
