//
//  RSVPDetailsViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

enum ContentType {
    case inviteNotSent
    case thankYouNotSent
}

class RsvpDetailsViewController: UITableViewController {
    
    // MARK: Properties
    
    var contentMode: ContentType = .inviteNotSent
    var guests: [Guest] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setup() {
        tableView.allowsSelection = false
        
        switch contentMode {
        case .inviteNotSent:
            title = "Status: Invite Not Sent"
            guests = GuestList.shared.getGuestsWithNoInvitations()
        case .thankYouNotSent:
            title = "Status: Thank-You Not Sent"
            guests = GuestList.shared.getGuestsWithNoThankYousSent()
        }
    }
    
    private func setupTableView() {
        registerNibs()
    }
    
    private func registerNibs() {
        let cellNib = UINib(nibName: GuestTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: GuestTableViewCell.cellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellIdentifier, for: indexPath) as! GuestTableViewCell
        let guest = guests[indexPath.row]
        let lastname = guest.lastname == nil ? "" : " \(guest.lastname!)"
        cell.setGuestName(to: guest.firstname + " " + lastname)
        cell.setCompanyLabel(to: 0)
        cell.checkboxImageIsHidden = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
