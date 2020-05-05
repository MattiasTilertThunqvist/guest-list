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
    
    // MARK: Custom types
    
    enum RSVP: Int, Codable {
        case noResponse
        case attending
        case declined
        
        var description: String {
            switch self {
            case .noResponse: return "No Response"
            case .attending: return "Attending"
            case .declined: return "Declined"
            }
        }
    }
    
    enum List: Int, Codable {
        case guestList
        case waitingList
        
        var description: String {
            switch self {
                case .guestList: return "Guest List"
                case .waitingList: return "Waiting List"
            }
        }
    }
    
    enum Role: Int, Codable {
        case guest
        case toastmaster
        case Bestman
        case HonoraryBridesmaid
        case Bridesmaid
        case Flowergirl
        
        var description: String {
            switch self {
                case .guest: return "Guest"
                case .toastmaster: return "Toastmaster/Tostmadame"
                case .Bestman: return "Bestman/Bestwoman"
                case .HonoraryBridesmaid: return "Honorary Bridesmaid"
                case .Bridesmaid: return "Bridesmaid"
                case .Flowergirl: return "Flower girl/Flower boy"
            }
        }
    }
    
    enum Relation: Int, Codable {
        case Family
        case Relatives
        case Friend
        
        var description: String {
            switch self {
                case .Family: return "Family"
                case .Relatives: return "Relatives"
                case .Friend: return "Friend"
            }
        }
    }
    
    enum FamilyStatus: Int, Codable {
        case Single
        case Relationship
        case Family
        
        var description: String {
            switch self {
                case .Single: return "Single"
                case .Relationship: return "Relationship/Married"
                case .Family: return "Family/Household"
            }
        }
    }
    
    enum Gender: Int, Codable {
        case Female
        case Male
        case Other
        
        var description: String {
            switch self {
                case .Female: return "Female"
                case .Male: return "Male"
                case .Other: return "Other"
            }
        }
    }
}

