//
//  PickerViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-05-06.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    // MARK: Properties
    
    private let animationTimeInterval = 0.3
    var pickerOptionsDelegate: PickerOptionsDelegate!
    var pickerOption: PickerOptions = .RSVP
    var currentPickerOption = 0
    
    // MARK: IBOutlet
    
    @IBOutlet private var backgroundDismissButton: UIButton!
    @IBOutlet private var descriptionLabel: MediumTextLabel!
    @IBOutlet private var doneButton: UIButton!
    @IBOutlet private var pickerView: UIPickerView!
    
    // MARK: IBAction
    
    @IBAction private func didTapBackgroundDismissButton(_ sender: UIButton) {
        animatedDismiss()
    }
    
    @IBAction private func didTapDoneButton(_ sender: UIButton) {
        pickerOptionsDelegate.pickerOptions(pickerOption, didSelectRowAtIndex: currentPickerOption)
        animatedDismiss()
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.backgroundDismissButton.alpha = 0.5
        }
    }
    
    private func setup() {
        backgroundDismissButton.alpha = 0
        doneButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        
        pickerView.selectRow(currentPickerOption, inComponent: 0, animated: false)
    }
    
    private func animatedDismiss() {
        UIView.animate(withDuration: animationTimeInterval, animations: {
            self.backgroundDismissButton.alpha = 0
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: UIPickerViewDataSource, UIPickerViewDelegate

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerOption {
        case .RSVP:
            return RSVP.allCases.count
        case .list:
            return List.allCases.count
        case .role:
            return Role.allCases.count
        case .relation:
            return Relation.allCases.count
        case .familyStatus:
            return FamilyStatus.allCases.count
        case .gender:
            return Gender.allCases.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerOption {
        case .RSVP:
            return RSVP.allCases[row].description
        case .list:
            return List.allCases[row].description
        case .role:
            return Role.allCases[row].description
        case .relation:
            return Relation.allCases[row].description
        case .familyStatus:
            return FamilyStatus.allCases[row].description
        case .gender:
            return Gender.allCases[row].description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPickerOption = row
    }
}
