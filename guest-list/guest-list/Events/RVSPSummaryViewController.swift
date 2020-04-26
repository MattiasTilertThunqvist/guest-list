//
//  RVSPSummaryViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-21.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class RVSPSummaryViewController: UIViewController {
    
    // MARK: Properties
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var acceptedStackView: UIStackView!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var acceptedNrLabel: UILabel!
    
    @IBOutlet weak var noResponseStackView: UIStackView!
    @IBOutlet weak var noResponseLabel: UILabel!
    @IBOutlet weak var noResponseNrLabel: UILabel!
    
    @IBOutlet weak var declinedStackView: UIStackView!
    @IBOutlet weak var declinedLabel: UILabel!
    @IBOutlet weak var declinedNrLabel: UILabel!
    
    @IBOutlet weak var nrTotalGuestsLabel: UILabel!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        noResponseStackView.layer.addBorder(edge: .left, color: .weddingVeryLightGray, thickness: 1)
        noResponseStackView.layer.addBorder(edge: .right, color: .weddingVeryLightGray, thickness: 1)
    }
    
    private func setup() {
        acceptedLabel.font = .weddingRegularFont(textSize: .small)
        acceptedNrLabel.font = .weddingRegularFont(35)
        noResponseLabel.font = .weddingRegularFont(textSize: .small)
        noResponseNrLabel.font = .weddingRegularFont(35)
        declinedLabel.font = .weddingRegularFont(textSize: .small)
        declinedNrLabel.font = .weddingRegularFont(35)
        nrTotalGuestsLabel.font = .weddingRegularFont(textSize: .small)
        
    }


}
