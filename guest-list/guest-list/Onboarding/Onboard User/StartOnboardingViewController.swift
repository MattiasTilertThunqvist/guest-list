//
//  StartOnboardingViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class StartOnboardingViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var signupWithEmailButton: LargeStickyButton!
    @IBOutlet weak var loginButton: LargeStickyButton!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        signupWithEmailButton.colorScheme = .email
        loginButton.colorScheme = .whiteOnTransparent
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        signupWithEmailButton.setTitle("SIGN UP WITH EMAIL", for: .normal)
        loginButton.setTitle("LOG IN", for: .normal)
    }
}
