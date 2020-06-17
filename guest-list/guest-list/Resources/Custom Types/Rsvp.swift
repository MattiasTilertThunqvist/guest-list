//
//  Rsvp.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

enum Rsvp: Int, Codable, CaseIterable {
    case noResponse
    case attending
    case maybe
    case declined
        
    var description: String {
        switch self {
            case .noResponse: return "No Response"
            case .attending: return "Attending"
            case .maybe: return "Maybe"
            case .declined: return "Declined"
        }
    }
    
    var icon: UIImage {
        switch self {
            case .noResponse: return #imageLiteral(resourceName: "exclamation-mark")
            case .attending: return #imageLiteral(resourceName: "check-green")
            case .maybe: return #imageLiteral(resourceName: "question-mark")
            case .declined: return #imageLiteral(resourceName: "cross-red")
        }
    }
}
