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
    var firstname: String
    var lastname: String?
    var email: String
    var address: String?
    var phoneNumber: String?
    var allergies: String?
    var disabilities: String?
    var transport: String?
    var notes: String?
    var rsvp: RSVP
    var list: List
    var role: Role
    var relation: Relation
    var familyStatus: FamilyStatus
    var gender: Gender
    var invitationSent: Bool
    var thankYouSent: Bool
    
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
    
    mutating func update( _ firstname: String, _ lastname: String?, _ email: String, _ address: String?, _ phoneNumber: String?, _ allergies: String?, _ disabilities: String?, _ transport: String?, _ notes: String?, _ rsvp: RSVP, _ list: List, _ role: Role, _ relation: Relation, _ familyStatus: FamilyStatus, _ gender: Gender, _ invitationSent: Bool, _ thankYouSent: Bool) {
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
