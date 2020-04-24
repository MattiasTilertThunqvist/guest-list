//
//  GuestTableViewHeader.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: Properties

    static let headerIdentifier = "GuestTableViewHeader"
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var totalGuestsLabel: UILabel!
    @IBOutlet weak private var addMoreGuestsLabel: UILabel!
    
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        totalGuestsLabel.font = .weddingRegularFont(textSize: .small)
        addMoreGuestsLabel.font = .weddingRegularFont(textSize: .medium)
    }
    
    // MARK: Accessors
    
    func setTotalGuestsLabel(to number: Int) {
        totalGuestsLabel.text = "\(number) TOTAL GUESTS"
    }
}
