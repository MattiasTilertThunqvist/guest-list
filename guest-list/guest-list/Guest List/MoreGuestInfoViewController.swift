//
//  MoreGuestInfoViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class MoreGuestInfoViewController: UIViewController {
    
    // MARK: Properties
    
    var address: String?
    var phoneNumber: String?
    var allergies: String?
    var disabilities: String?
    var transport:String?
    var notes: String?
    var invitationSent = false
    var thankYouSent = false
    
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
        invitationSent.toggle()
        setInvitationSentButtonStatus()
    }
    
    @IBAction private func didTapThankYouSentButton(_ sender: UIButton) {
        thankYouSent.toggle()
        setThankYouButtonStatus()
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
        addressTextField.text = address
        phoneNumberTextField.text = phoneNumber
        allergiesTextField.text = allergies
        disabilitiesTextField.text = disabilities
        transportTextField.text = transport
        notesTextField.text = notes
        setInvitationSentButtonStatus()
        setThankYouButtonStatus()
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    
    private func setInvitationSentButtonStatus() {
        let image: UIImage = invitationSent ? #imageLiteral(resourceName: "check-green") : #imageLiteral(resourceName: "check-gray")
        invitationSentButton.setImage(image, for: .normal)
    }
    
    private func setThankYouButtonStatus() {
        let image: UIImage = thankYouSent ? #imageLiteral(resourceName: "check-green") : #imageLiteral(resourceName: "check-gray")
        thankYouSentButton.setImage(image, for: .normal)
    }
    
    // MARK: Accessors
    
    typealias guestAddress = String?
    typealias guestPhoneNumber = String?
    typealias guestAllergies = String?
    typealias guestDisabilities = String?
    typealias guestTransport = String?
    typealias guestNotes = String?
    typealias guestInvitationSent = Bool
    typealias guestThankYouSent = Bool
    func getGuestInfo() -> (guestAddress, guestPhoneNumber, guestAllergies, guestDisabilities, guestTransport, guestNotes, guestInvitationSent, guestThankYouSent) {
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
        
        return (address, phoneNumber, allergies, disabilities, transport, notes, invitationSent, thankYouSent)
    }
}
