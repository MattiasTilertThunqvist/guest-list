//
//  ViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class GuestListViewController: UITableViewController {
    
    // MARK: Properties
    
    
    // MARK: IBOutlets
    

    

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setup() {
        
    }
    
    private func setupTableView() {
        registerNibs()
    }
    
    private func registerNibs() {
        let headerNib = UINib(nibName: GuestTableViewHeader.headerIdentifier, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: GuestTableViewHeader.headerIdentifier)
        
        let cellNib = UINib(nibName: GuestTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: GuestTableViewCell.cellIdentifier)
    }
    
    // MARK: Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GuestTableViewHeader.headerIdentifier) as! GuestTableViewHeader
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTableViewHeader))
        header.addGestureRecognizer(tapGesture)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    @objc private func didTapTableViewHeader() {
        let viewController = StoryboardInstance.addGuestsViewController()
        present(viewController, animated: true) {
            // TODO: Reload data
        }
    }
    
    // MARK: Rows
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellIdentifier, for: indexPath) as! GuestTableViewCell
        cell.setGuestName(to: "Mattias Tilert Thunqvist")
        cell.setCompanyLabel(to: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
 
