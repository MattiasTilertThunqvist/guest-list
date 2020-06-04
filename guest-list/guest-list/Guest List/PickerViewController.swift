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
    
    private let animationTimeInterval = 0.2
    var pickerOptionsDelegate: PickerOptionsDelegate!
    var pickerOption: PickerOptions = .rsvp
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
        UIView.animate(withDuration: animationTimeInterval) {
            self.backgroundDismissButton.alpha = 0.5
        }
    }
    
    private func setup() {
        backgroundDismissButton.alpha = 0
        doneButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        descriptionLabel.text = pickerOption.description
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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerOption {
        case .rsvp:
            return Rsvp.allCases.count
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // Container view
        let customView = view ?? UIView()
        let rowSize = pickerView.rowSize(forComponent: component)
        customView.frame.size = rowSize
        
        // Subviews
        let label = UILabel()
        let imageView = UIImageView()
        imageView.isHidden = true // Hidden by default
        
        switch pickerOption {
        case .rsvp:
            label.text = Rsvp.allCases[row].description
            imageView.image = Rsvp.allCases[row].icon
            imageView.isHidden = false
        case .list:
            label.text = List.allCases[row].description
        case .role:
            label.text = Role.allCases[row].description
        case .relation:
            label.text = Relation.allCases[row].description
        case .familyStatus:
            label.text = FamilyStatus.allCases[row].description
        case .gender:
            label.text = Gender.allCases[row].description
        }
        
        let spacing: CGFloat = 16
        let height = rowSize.height - spacing
        
        label.textColor = .weddingGray
        label.font = .weddingRegularFont(textSize: .large)
        label.sizeToFit()
        label.frame.size.height = height
        label.center = customView.center
        
        imageView.frame.size = CGSize(width: height, height: height)
        imageView.frame.origin.x = label.frame.maxX + spacing
        imageView.frame.origin.y = label.frame.origin.y
        
        customView.addSubview(imageView)
        customView.addSubview(label)
        return customView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPickerOption = row
    }
}
