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
    
    @IBOutlet weak var emailTextField: LargeTextField!
    @IBOutlet weak var passwordTextField: LargeTextField!
    @IBOutlet weak var loginWithEmailButton: LargeStickyButton!
    
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
    
    func setUp() {
        navigationItem.title = "LOG IN"
        loginWithEmailButton.colorScheme = .email
        
        // Place the items outside of the view. When view appears they will be animated to original position.
        let transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        emailTextField.transform = transform
        passwordTextField.transform = transform
        loginWithEmailButton.transform = transform
    }
    
    func animateItemsIntoView() {
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
    
    @IBAction func loginWithEmailButtonWasPressed(_ sender: LargeStickyButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            // TODO: Manage incorrect textfield input
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            // TODO: Manage incorrect textfield input
            return
        }
    }
}
