//
//  PickerOptions.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-05-06.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum PickerOptions {
    case rsvp
    case list
    case role
    case relation
    case familyStatus
    case gender
    
    var description: String {
        switch self {
        case .rsvp: return "RSVP"
        case .list: return "List"
        case .role: return "Role"
        case .relation: return "Relation"
        case .familyStatus: return "Family Status"
        case .gender: return "Gender"
        }
    }
}
