//
//  BaseGuestListViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-15.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class BaseGuestListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        checkUserAuthentication()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(startPageViewController), name: .OnboardingDidFinish, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signOut), name: .SignOut, object: nil)
    }
    
    private func checkUserAuthentication() {
        NetworkManager.shared.isAuthenticated() ? startPageViewController() : startOnboarding()
    }
    
    private func startOnboarding() {
        let viewController = StoryboardInstance.onboardingNavigationController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
    }
    
    @objc private func startPageViewController() {
        let viewController = StoryboardInstance.pageViewController()
        viewController.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    @objc private func signOut() {
        NetworkManager.shared.signOut { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Couldn't sing out", message: error.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.navigationController?.popToRootViewController(animated: false)

            let viewController = StoryboardInstance.onboardingNavigationController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
