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
    
    @IBOutlet weak private var headerLabel: UILabel!
    @IBOutlet weak private var addMoreGuestsLabel: UILabel!
    
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        headerLabel.font = .weddingRegularFont(textSize: .small)
        addMoreGuestsLabel.font = .weddingRegularFont(textSize: .large)
    }
    
    // MARK: Accessors
    
    func setHeaderLabel(to text: String) {
        headerLabel.text = text.uppercased()
    }
}
