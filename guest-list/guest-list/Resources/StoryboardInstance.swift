//
//  StoryboardInstance.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

final class StoryboardInstance {
    
    private static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func guestListViewController() -> GuestListViewController {
        return mainStoryboard.instantiateViewController(withIdentifier: "GuestListViewController") as! GuestListViewController
    }
    
    static func eventsViewController() -> EventsViewController {
        return mainStoryboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
    }
    
}
