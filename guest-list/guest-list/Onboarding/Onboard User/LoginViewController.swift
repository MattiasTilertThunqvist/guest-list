//
//  LoginViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var emailTextField: LargeTextField!
    @IBOutlet private weak var passwordTextField: LargeTextField!
    @IBOutlet private weak var loginWithEmailButton: LargeStickyButton!
    
    @IBAction private func emailPrimaryActionTriggered(_ sender: LargeTextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction private func passwordPrimaryActionTriggered(_ sender: LargeTextField) {
        passwordTextField.resignFirstResponder()
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
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: View
    
    private func setUp() {
        navigationItem.title = "LOG IN"
        loginWithEmailButton.colorScheme = .email
        
        // Place the items outside of the view. When view appears they will be animated to original position.
        let transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        emailTextField.transform = transform
        passwordTextField.transform = transform
        loginWithEmailButton.transform = transform
    }
    
    private func animateItemsIntoView() {
        var late = Double(0.1)
        let duration = Double(0.2)
        
        UIView.animate(withDuration: duration, delay: late, options: [], animations: {
            self.emailTextField.transform = .identity
            late += 0.1
        })
        
        UIView.animate(withDuration: duration, delay: late, options: [], animations: {
            self.passwordTextField.transform = .identity
            late += 0.1
        })
        
        UIView.animate(withDuration: duration, delay: late, options: [], animations: {
            self.loginWithEmailButton.transform = .identity
            late += 0.1
        })
    }
    
    
    // MARK: IBAction
    
    @IBAction private func loginWithEmailButtonWasPressed(_ sender: LargeStickyButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            emailTextField.inputIsValid = false
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordTextField.inputIsValid = false
            return
        }
        
        NetworkManager.shared.signIn(withEmail: email, password: password) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Could not sign in", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            NotificationCenter.default.post(name: .OnboardingDidFinish, object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
