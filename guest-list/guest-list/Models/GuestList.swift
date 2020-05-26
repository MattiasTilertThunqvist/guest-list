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
            guests.sort{ $0.firstname < $1.firstname }
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
    
    func getGuest(atIndex index: Int) -> Guest {
        return guests[index]
    }
    
    func removeAllGuests() {
        guests.removeAll()
    }
    
    func countGuests() -> Int {
        return guests.count
    }
    
    func countAcceptedRsvps() -> Int {
        var count = 0
        guests.forEach({ $0.rsvp == .attending ? count += 1 : nil})
        return count
    }
    
    func countNoResponsRsvps() -> Int {
        var count = 0
        guests.forEach({ $0.rsvp == .noResponse ? count += 1 : nil})
        return count
    }
    
    func countDeclingedRsvps() -> Int {
        var count = 0
        guests.forEach({ $0.rsvp == .declined ? count += 1 : nil})
        return count
    }
    
    func countMaybeRsvps() -> Int {
        var count = 0
        guests.forEach({ $0.rsvp == .maybe ? count += 1 : nil})
        return count
    }
    
    func countInvitationsSent() -> Int {
        var count = 0
        guests.forEach({ $0.invitationSent == true ? count += 1 : nil })
        return count
    }
    
    func countThankYousSent() -> Int {
        var count = 0
        guests.forEach({ $0.thankYouSent == true ? count += 1 : nil })
        return count
    }
    
    func getGuestsWithNoInvitations() -> [Guest] {
        var guests: [Guest] = []
        self.guests.forEach({ $0.invitationSent == false ? guests.append($0) : nil })
        return guests
    }
    
    func getGuestsWithNoThankYousSent() -> [Guest] {
        var guests: [Guest] = []
        self.guests.forEach({ $0.thankYouSent == false ? guests.append($0) : nil })
        return guests
    }
}
