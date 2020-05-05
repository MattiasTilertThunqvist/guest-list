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

class RSVPDetailsViewController: UITableViewController {
    
    // MARK: Properties
    
    var contentMode: ContentType = .inviteNotSent
    var mockedGuestList: [Guest] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setup() {
        switch contentMode {
        case .inviteNotSent:
            title = "Status: Invite Not Sent"
            mockedGuestList = NetworkManager.shared.mockedGuestList
        case .thankYouNotSent:
            title = "Status: Thank-You Not Sent"
            mockedGuestList = NetworkManager.shared.mockedGuestList
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
        return mockedGuestList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellIdentifier, for: indexPath) as! GuestTableViewCell
        let guest = mockedGuestList[indexPath.row]
        
        cell.setGuestName(to: guest.firstname + " " + "MockedLastname")
        cell.setCompanyLabel(to: 0)
        cell.setImage(to: #imageLiteral(resourceName: "forward-arrow-lightgray"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
