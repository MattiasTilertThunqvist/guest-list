//
//  ViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestListViewController: UITableViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(guestListDidChange), name: .GuestListDidChange, object: nil)
    }
    
    private func setupTableView() {
        registerNibs()
    }
    
    @objc private func guestListDidChange() {
        tableView.reloadData()
    }
    
    // MARK: TableView
    
    private func registerNibs() {
        let headerNib = UINib(nibName: GuestTableViewHeader.headerIdentifier, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: GuestTableViewHeader.headerIdentifier)
        
        let cellNib = UINib(nibName: GuestTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: GuestTableViewCell.cellIdentifier)
    }
    
    // MARK: TableView Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GuestTableViewHeader.headerIdentifier) as! GuestTableViewHeader
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTableViewHeaderTap))
        header.addGestureRecognizer(tapGesture)
        header.setTotalGuestsLabel(to: GuestList.shared.countGuests())
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    @objc func handleTableViewHeaderTap() {
        presentAddGuestViewController(withGuest: nil)
    }
    
    private func presentAddGuestViewController(withGuest guest: Guest?) {
        let viewController = StoryboardInstance.addGuestsViewController()
        viewController.guest = guest
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: TableView Rows
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GuestList.shared.countGuests()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellIdentifier, for: indexPath) as! GuestTableViewCell
        let guest = GuestList.shared.getGuest(atIndex: indexPath.row)
        let lastname = guest.lastname == nil ? "" : " \(guest.lastname!)"
        cell.setGuestName(to: guest.firstname + lastname)
        cell.setCheckboxImage(toRsvp: guest.rsvp)
        cell.setCompanyLabel(to: 0)
        
        // User can't modify info about themselves, it can only be done in settings. 
        if guest.role == .weddingCouple {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest = GuestList.shared.getGuest(atIndex: indexPath.row)
        presentAddGuestViewController(withGuest: guest)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
