//
//  GuestTableViewCell.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let cellIdentifier = "GuestTableViewCell"
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var companyLabel: UILabel!
    @IBOutlet private var contentImageView: UIImageView!
    
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Accessors
    
    func setGuestName(to text: String) {
        nameLabel.text = text
    }
    
    func setCompanyLabel(to number: Int) {
        companyLabel.text = number == 0 ? nil : "(+\(number))"
    }
    
    func setImage(to image: UIImage) {
        contentImageView.image = image
    }
}
