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
}
