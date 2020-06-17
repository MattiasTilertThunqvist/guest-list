//
//  PageViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-21.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

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
    
    @IBAction private func valueChangedSegmentedControl(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = index == 0 ? .reverse : .forward // Modify if nr of viewControllers increase
        setViewControllers([orderedViewControllers[index]], direction: direction, animated: true, completion: nil)
    }
    
    @IBAction private func didTapSignOutButton(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .SignOut, object: nil)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadGuestList()
    }
    
    private func setup() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .weddingWhite
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = .weddingWhite
        navigationController?.navigationBar.isTranslucent = false
        extendedLayoutIncludesOpaqueBars = true // Set contentview top constrain to navbar
    }
    
    private func loadGuestList() {
        NetworkManager.shared.getGuestList { (error) in
            if let error = error {
                fatalError("Couldn't load guest list from Firestore: \(error)")
            }
            
            self.setupPages()
        }
    }
    
    private func setupPages() {
        dataSource = self
        delegate = self
        
        navigationController?.navigationBar.isHidden = false
        
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentIndex = orderedViewControllers.firstIndex(where: { $0 == pageViewController.viewControllers?.last }) else { return }
            segmentedControl.selectedSegmentIndex = currentIndex
        }
    }
}
