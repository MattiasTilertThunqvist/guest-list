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
    @IBOutlet private var checkboxImageView: UIImageView!
    
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
    
    func setCheckboxImage(toRsvp rsvp: RSVP) {
        switch rsvp {
        case .noResponse:
            checkboxImageView.image = #imageLiteral(resourceName: "exclamation-mark")
        case .attending:
            checkboxImageView.image = #imageLiteral(resourceName: "check-green")
        case .declined:
            checkboxImageView.image = #imageLiteral(resourceName: "cross-red")
        case .maybe:
            checkboxImageView.image = #imageLiteral(resourceName: "question-mark")
        }
    }
    
    var checkboxImageIsHidden = false {
        willSet {
            checkboxImageView.isHidden = newValue
        }
    }
}
