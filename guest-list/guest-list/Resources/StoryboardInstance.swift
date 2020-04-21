//
//  StoryboardInstance.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

final class StoryboardInstance {
    
    private static let pageScrollStoryboard = UIStoryboard(name: "PageSroll", bundle: nil)
    private static let guestListStoryboard = UIStoryboard(name: "GuestList", bundle: nil)
    private static let eventsStoryboard = UIStoryboard(name: "Events", bundle: nil)
    
    static func guestListViewController() -> GuestListViewController {
        return guestListStoryboard.instantiateViewController(withIdentifier: "GuestListViewController") as! GuestListViewController
    }
    
    static func eventsViewController() -> EventsViewController {
        return eventsStoryboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
    }
    
}
