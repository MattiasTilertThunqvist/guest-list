//
//  PageViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-21.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class PageViewController: UIPageViewController {
    
    // MARK: Properties
    
    private (set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            StoryboardInstance.guestListViewController(),
            StoryboardInstance.RVSPSummaryViewController()
        ]
    }()
    
    // MARK: IBOutlet
    
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    
    // MARK: IBAction
    
    @IBAction func valueChangedSegmentedControl(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = index == 0 ? .reverse : .forward // Modify if nr of viewControllers increase
        setViewControllers([orderedViewControllers[index]], direction: direction, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnboardingButton(_ sender: UIBarButtonItem) {
        let viewController = StoryboardInstance.onboardingNavigationController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupPages()
        
        NetworkManager.shared.getGuestList { (error) in
            
        }
    }
    
    private func setup() {

    }
    
    private func setupPages() {
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < orderedViewControllers.count else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
}
