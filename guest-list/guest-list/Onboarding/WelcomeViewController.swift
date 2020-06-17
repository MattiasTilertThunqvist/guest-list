//
//  ViewController.swift
//  wedding
//
//  Created by Mattias Tilert Thunqvist on 2018-01-05.
//  Copyright © 2018 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class StartOnboardingViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlet
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var signupWithEmailButton: LargeStickyButton!
    @IBOutlet weak var loginButton: LargeStickyButton!
    
    // MARK: IBActions
    
    
    
    // MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        UIApplication.shared.setStatusBarBackgroundColor(to: .clear)
    }
    
    func setUp() {
        navigationController?.transparentNavigationBar()
        navigationItem.hidesBackButton = true
        
        signupWithEmailButton.colorScheme = .email
        loginButton.colorScheme = .whiteOnTransparent
        
        signupWithEmailButton.setTitle(NSLocalizedString("Sign up with email", comment: "").uppercased(), for: .normal)
        loginButton.setTitle(NSLocalizedString("Log in", comment: "").uppercased(), for: .normal)
    }
    
    // MARK: Override
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
