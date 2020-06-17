//
//  List.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum List: Int, Codable, CaseIterable {
    case guestList
    case waitingList
        
    var description: String {
        switch self {
            case .guestList: return "Guest List"
            case .waitingList: return "Waiting List"
        }
    }
}
