//
//  Role.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum Role: Int, Codable, CaseIterable {
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
