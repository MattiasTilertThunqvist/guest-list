//
//  PickerOptions.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-05-06.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum PickerState {
    case RSVP, list, role, relation, familyStatus, gender
    
//
//
// return all the options
//
//
}
    
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
    case bestman
    case honoraryBridesmaid
    case bridesmaid
    case flowergirl
    case weddingCouple
        
    var description: String {
        switch self {
            case .guest: return "Guest"
            case .toastmaster: return "Toastmaster/Tostmadame"
            case .bestman: return "Bestman/Bestwoman"
            case .honoraryBridesmaid: return "Honorary Bridesmaid"
            case .bridesmaid: return "Bridesmaid"
            case .flowergirl: return "Flower Girl/Flower Boy"
        case .weddingCouple: return "Wedding Couple"
        }
    }
}
    
enum Relation: Int, Codable {
    case family
    case relatives
    case friend
        
    var description: String {
        switch self {
            case .family: return "Family"
            case .relatives: return "Relatives"
            case .friend: return "Friend"
        }
    }
}
    
enum FamilyStatus: Int, Codable {
    case single
    case relationship
    case family
    
    var description: String {
        switch self {
            case .single: return "Single"
            case .relationship: return "Relationship/Married"
            case .family: return "Family/Household"
        }
    }
}
    
enum Gender: Int, Codable {
    case female
    case male
    case other
    
    var description: String {
        switch self {
            case .female: return "Female"
            case .male: return "Male"
            case .other: return "Other"
        }
    }
}
