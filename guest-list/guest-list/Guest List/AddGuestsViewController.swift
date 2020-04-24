//
//  AddGuestsViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class AddGuestsViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var doneButton: UIButton!
    @IBOutlet weak var companySegmentedControl: WeddingSegmentedControl!
    
    // MARK: IBActions

    @IBAction func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDoneButton(_ sender: UIButton) {
        // TODO: Check that requiered fields are filled in 
    }
    
    @IBAction func valueChangedSegmentedControl(_ sender: WeddingSegmentedControl) {
        
    }
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        titleLabel.font = .weddingRegularFont(textSize: .large)
        cancelButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        doneButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        
        companySegmentedControl.layer.maskedCorners = .init() // Remove rounded corners
    }
}
