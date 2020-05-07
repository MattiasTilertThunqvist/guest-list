//
//  GuestStatusViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestStatusViewController: UIViewController {
    
    // MARK: Properties
    
    private var rsvp: RSVP = .noResponse
    private var list: List = .guestList
    private var role: Role = .guest
    private var relation: Relation = .family
    private var familyStatus: FamilyStatus = .single
    private var gender: Gender = .female
    
    // MARK: IBOutlets
    
    @IBOutlet private var rsvpButton: BoxButton!
    @IBOutlet private var listButton: BoxButton!
    @IBOutlet private var roleButton: BoxButton!
    @IBOutlet private var relationButton: BoxButton!
    @IBOutlet private var familyStatusButton: BoxButton!
    @IBOutlet private var genderButton: BoxButton!
    
    // MARK: IBActions
    
    @IBAction private func didTapRsvpButton(_ sender: BoxButton) {
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
        setup()
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
    
    private func setup() {
        rsvpButton.setTitle(rsvp.description, for: .normal)
        listButton.setTitle(list.description, for: .normal)
        roleButton.setTitle(role.description, for: .normal)
        relationButton.setTitle(relation.description, for: .normal)
        familyStatusButton.setTitle(familyStatus.description, for: .normal)
        genderButton.setTitle(gender.description, for: .normal)
    }
    
    private func showPickerViewController(for pickerOption: PickerOptions) {
        let viewController = StoryboardInstance.pickerViewControlelr()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.pickerOptionsDelegate = self
        viewController.pickerOption = pickerOption
        
        switch pickerOption {
        case .RSVP:
            viewController.currentPickerOption = rsvp.rawValue
        case .list:
            viewController.currentPickerOption = list.rawValue
        case .role:
            viewController.currentPickerOption = role.rawValue
        case .relation:
            viewController.currentPickerOption = relation.rawValue
        case .familyStatus:
            viewController.currentPickerOption = familyStatus.rawValue
        case .gender:
            viewController.currentPickerOption = gender.rawValue
        }
        
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: PickerOptionsDelegate

extension GuestStatusViewController: PickerOptionsDelegate {
    
    func pickerOptions(_ pickerOption: PickerOptions, didSelectRowAtIndex index: Int) {
        switch pickerOption {
        case .RSVP:
            self.rsvp = RSVP(rawValue: index)!
            rsvpButton.setTitle(rsvp.description, for: .normal)
        case .list:
            self.list = List(rawValue: index)!
            listButton.setTitle(list.description, for: .normal)
        case .role:
            self.role = Role(rawValue: index)!
            roleButton.setTitle(role.description, for: .normal)
        case .relation:
            self.relation = Relation(rawValue: index)!
            relationButton.setTitle(relation.description, for: .normal)
        case .familyStatus:
            self.familyStatus = FamilyStatus(rawValue: index)!
            familyStatusButton.setTitle(familyStatus.description, for: .normal)
        case .gender:
            self.gender = Gender(rawValue: index)!
            genderButton.setTitle(gender.description, for: .normal)
        }
    }
}
