//
//  StartOnboardingViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
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
    
    func setUp() {        
        signupWithEmailButton.colorScheme = .email
        loginButton.colorScheme = .whiteOnTransparent
        
        signupWithEmailButton.setTitle("SIGN UP WITH EMAIL", for: .normal)
        loginButton.setTitle("LOG IN", for: .normal)
    }
}
