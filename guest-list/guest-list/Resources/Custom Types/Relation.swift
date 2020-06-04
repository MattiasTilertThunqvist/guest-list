//
//  Relation.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum Relation: Int, Codable, CaseIterable {
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
