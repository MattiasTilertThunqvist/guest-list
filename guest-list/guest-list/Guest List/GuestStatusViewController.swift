//
//  GuestStatusViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestStatusViewController: UIViewController {
    
    // MARK: IBActions
    
    @IBAction private func didTapRSVPButton(_ sender: BoxButton) {
        showPickerViewController(for: .RSVP)
    }
    
    @IBAction private func didTapListButton(_ sender: BoxButton) {
        showPickerViewController(for: .list)
    }
    
    @IBAction private func didTapRoleButton(_ sender: BoxButton) {
        showPickerViewController(for: .role)
    }
    
    @IBAction private func didTapRelationButton(_ sender: BoxButton) {
        showPickerViewController(for: .relation)
    }
    
    @IBAction private func didTapFamilyStatusButton(_ sender: BoxButton) {
        showPickerViewController(for: .familyStatus)
    }
    
    @IBAction private func didTapGenderButton(_ sender: BoxButton) {
        showPickerViewController(for: .gender)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    
    private func showPickerViewController(for pickerOption: PickerState) {
        let viewController = StoryboardInstance.pickerViewControlelr()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.pickerOption = pickerOption
        present(viewController, animated: true, completion: nil)
    }
}
