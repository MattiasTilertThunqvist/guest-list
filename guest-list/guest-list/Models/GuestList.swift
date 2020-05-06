//
//  GuestList.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-05-06.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

class GuestList {
    
    // MARK: Properties
    
    static let shared = GuestList()
    private var guests: [Guest] = [] {
        didSet {
            guests.sort { $0.firstname < $1.firstname }
        }
    }
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Accessors
    
    func setGuests(to guests: [Guest]) {
        self.guests = guests
    }
    
    /// Add new guest and update existing
    func setGuest(to guest: Guest) {
        if let index = guests.firstIndex(where: { $0.id == guest.id }) {
            // Update existing guest
            guests[index] = guest
        } else {
            // Add new guest
            guests.append(guest)
        }
    }
    
    func getGuests() -> [Guest] {
        return guests
    }
}
