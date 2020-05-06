//
//  Guest.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

struct Guest: Codable {
    
    // MARK: Properties
    
    let id: String
    let firstname: String
    let lastname: String?
    let email: String
    let address: String?
    let phoneNumber: String?
    let allergies: String?
    let disabilities: String?
    let transport: String?
    let notes: String?
    let rsvp: RSVP
    let list: List
    let role: Role
    let relation: Relation
    let familyStatus: FamilyStatus
    let gender: Gender
    let invitationSent: Bool
    let thankYouSent: Bool
    
    // MARK: Init
    
    init(_ id: String, _ firstname: String, _ lastname: String?, _ email: String, _ address: String?, _ phoneNumber: String?, _ allergies: String?, _ disabilities: String?, _ transport: String?, _ notes: String?, _ rsvp: RSVP, _ list: List, _ role: Role, _ relation: Relation, _ familyStatus: FamilyStatus, _ gender: Gender, _ invitationSent: Bool, _ thankYouSent: Bool) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.allergies = allergies
        self.disabilities = disabilities
        self.transport = transport
        self.notes = notes
        self.rsvp = rsvp
        self.list = list
        self.role = role
        self.relation = relation
        self.familyStatus = familyStatus
        self.gender = gender
        self.invitationSent = invitationSent
        self.thankYouSent = thankYouSent
    }
}
