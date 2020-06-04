//
//  Gender.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum Gender: Int, Codable, CaseIterable {
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
