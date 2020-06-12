//
//  RsvpDetailsViewController.swift
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
    let searchController = UISearchController(searchResultsController: nil)
    var filteredGuests: [String] = [] // Guest id
    var isFiltering: Bool {
        let isSearchBarEmpty = searchController.searchBar.text?.isEmpty ?? true
        return !isSearchBarEmpty
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupSearchController()
    }
    
    private func setup() {
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
        if isFiltering {
            return filteredGuests.count
        }
        
        return guests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellIdentifier, for: indexPath) as! GuestTableViewCell
        
        let guest: Guest = {
            if isFiltering {
                let guestId = filteredGuests[indexPath.row]
                return GuestList.shared.getGuest(withId: guestId)
            } else {
                return guests[indexPath.row]
            }
        }()
        
        let lastname = guest.lastname == nil ? "" : " \(guest.lastname!)"
        cell.setGuestName(to: guest.firstname + " " + lastname)
        cell.setCompanyLabel(to: 0)
        cell.checkboxImageIsHidden = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest: Guest = {
            if isFiltering {
                let guestId = filteredGuests[indexPath.row]
                return GuestList.shared.getGuest(withId: guestId)
            } else {
                return guests[indexPath.row]
            }
        }()
        presentManageGuestViewController(withGuest: guest)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Helpers

extension RsvpDetailsViewController {
    
    private func presentManageGuestViewController(withGuest guest: Guest?) {
        let viewController = StoryboardInstance.addGuestsViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.guest = guest
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: SearchController

extension RsvpDetailsViewController : UISearchResultsUpdating, UISearchBarDelegate {
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For Guests"
        searchController.searchBar.tintColor = .weddingGray
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.enablesReturnKeyAutomatically = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGuests = GuestList.shared.filter(guests, forSearchText: searchText)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }
}
