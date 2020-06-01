//
//  ViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestListViewController: UIViewController {
    
    // MARK: Properties
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    var filteredGuests: [String] = [] // Guest id
    var isFiltering: Bool {
        let isSearchBarEmpty = searchBar.text?.isEmpty ?? true
        return !isSearchBarEmpty
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupSearchBar()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(guestListDidChange), name: .GuestListDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Helpers
    
    @objc private func guestListDidChange() {
        filterContentForSearchText(searchBar.text!) // Update filteredGuests
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

// MARK: UITableView

extension GuestListViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        registerNibs()
    }
    
    private func registerNibs() {
        let headerNib = UINib(nibName: GuestTableViewHeader.headerIdentifier, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: GuestTableViewHeader.headerIdentifier)
        
        let cellNib = UINib(nibName: GuestTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: GuestTableViewCell.cellIdentifier)
    }
    
    // MARK: TableView Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GuestTableViewHeader.headerIdentifier) as! GuestTableViewHeader
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTableViewHeaderTap))
        header.addGestureRecognizer(tapGesture)
        
        let headerText: String = {
            let totalGuests = GuestList.shared.countGuests()
            
            if isFiltering {
                return "FILTERING \(filteredGuests.count) OF \(totalGuests)"
            } else {
                return "\(totalGuests) TOTAL GUESTS"
            }
        }()

        header.setHeaderLabel(to: headerText)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    @objc func handleTableViewHeaderTap() {
        presentManageGuestViewController(withGuest: nil)
    }
    
    private func presentManageGuestViewController(withGuest guest: Guest?) {
        let viewController = StoryboardInstance.addGuestsViewController()
        viewController.guest = guest
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: TableView Rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGuests.count
        }
        
        return GuestList.shared.countGuests()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellIdentifier, for: indexPath) as! GuestTableViewCell
        
        let guest: Guest = {
            if isFiltering {
                let guestId = filteredGuests[indexPath.row]
                return GuestList.shared.getGuest(withId: guestId)
            } else {
                return GuestList.shared.getGuest(atIndex: indexPath.row)
            }
        }()
        
        let lastname = guest.lastname == nil ? "" : " \(guest.lastname!)"
        cell.setGuestName(to: guest.firstname + lastname)
        cell.setCheckboxImage(toRsvp: guest.rsvp)
        cell.setCompanyLabel(to: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest: Guest = {
            if isFiltering {
                let guestId = filteredGuests[indexPath.row]
                return GuestList.shared.getGuest(withId: guestId)
            } else {
                return GuestList.shared.getGuest(atIndex: indexPath.row)
            }
        }()
        presentManageGuestViewController(withGuest: guest)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Keyboard appearence

extension GuestListViewController {
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        tableView.contentInset.bottom = keyboardFrame.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset.bottom = 0
    }
}

// MARK: SearchController

extension GuestListViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search For Guests"
        searchBar.tintColor = .darkGray
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGuests = GuestList.shared.getGuestIds(forSearchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignSearchMode()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        resignSearchMode()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resignSearchMode()
    }
    
    private func resignSearchMode() {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
