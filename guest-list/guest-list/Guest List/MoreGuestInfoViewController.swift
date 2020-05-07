//
//  MoreGuestInfoViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class MoreGuestInfoViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var addressTextField: LargeTextField!
    @IBOutlet weak private var phoneNumberTextField: LargeTextField!
    @IBOutlet weak private var allergiesTextField: LargeTextField!
    @IBOutlet weak private var disabilitiesTextField: LargeTextField!
    @IBOutlet weak private var transportTextField: LargeTextField!
    @IBOutlet weak private var notesTextField: LargeTextField!
    @IBOutlet private var invitationSentButton: UIButton!
    @IBOutlet private var thankYouSentButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction private func addressPrimaryActionTriggered(_ sender: LargeTextField) {
        addressTextField.resignFirstResponder()
    }
    
    @IBAction private func allergiesPrimaryActionTriggered(_ sender: LargeTextField) {
        allergiesTextField.resignFirstResponder()
    }
    
    @IBAction private func disabilitiesPrimaryActionTriggered(_ sender: LargeTextField) {
        disabilitiesTextField.resignFirstResponder()
    }
    
    @IBAction private func transportPrimaryActionTriggered(_ sender: LargeTextField) {
        transportTextField.resignFirstResponder()
    }
    
    @IBAction private func notesPrimaryActionTriggered(_ sender: LargeTextField) {
        notesTextField.resignFirstResponder()
    }
    
    @IBAction private func didTapInvitationSentButton(_ sender: UIButton) {
        
    }
    
    @IBAction private func didTapThankYouSentButton(_ sender: UIButton) {
        
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
    
    private func setup() {

    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    
    // MARK: Accessors
    
    typealias address = String?
    typealias phoneNumber = String?
    typealias allergies = String?
    typealias disabilities = String?
    typealias transport = String?
    typealias notes = String?
    func getGuestInfo() -> (address, phoneNumber, allergies, disabilities, transport, notes) {
        var address = addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        address = address == "" ? nil : address
        
        var phoneNumber = phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        phoneNumber = phoneNumber == "" ? nil : phoneNumber
        
        var allergies = allergiesTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        allergies = allergies == "" ? nil : allergies
        
        var disabilities = disabilitiesTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        disabilities = disabilities == "" ? nil : disabilities
        
        var transport = transportTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        transport = transport == "" ? nil : transport
        
        var notes = notesTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        notes = notes == "" ? nil : notes
        
        return (address, phoneNumber, allergies, disabilities, transport, notes)
    }
}
