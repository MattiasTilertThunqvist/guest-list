//
//  FamilyStatus.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum FamilyStatus: Int, Codable, CaseIterable {
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
