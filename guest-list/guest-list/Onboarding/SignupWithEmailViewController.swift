//
//  SignupWithEmailViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//



import UIKit

class SignupWithEmailViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlet
    
    @IBOutlet weak var emailTextField: LargeTextField!
    @IBOutlet weak var passwordTextField: LargeTextField!
    @IBOutlet weak var signUpButton: LargeStickyButton!
    @IBOutlet weak var firstnameTextField: LargeTextField!
    @IBOutlet weak var lastnameTextField: LargeTextField!
    @IBOutlet var textfieldsCollection: [LargeTextField]!
    
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

    func setUp() {        
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
    
    func animateItemsIntoView() {
        var late = Double(0.2)
        let duration = Double(0.3)
        
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
    
    @IBAction func signUpButtonWasPressed(_ sender: LargeStickyButton) {
        guard let firstname = firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstname.isEmpty else {
            // TODO: Handle empty textfield
            return
        }
        
        guard let lastname = lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !lastname.isEmpty else {
            // TODO: Handle empty textfield
            return
        }

        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            // TODO: Handle empty textfield
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else {
            // TODO: Handle empty textfield
            // TODO: Password need to be at least 6 cahracters
            return
        }
    }
}
