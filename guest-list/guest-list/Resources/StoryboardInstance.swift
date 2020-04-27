//
//  StoryboardInstance.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

final class StoryboardInstance {
    
    private static let onboardingStoryboard = UIStoryboard(name: "OnboardUser", bundle: nil)
    private static let pageScrollStoryboard = UIStoryboard(name: "PageSroll", bundle: nil)
    private static let guestListStoryboard = UIStoryboard(name: "GuestList", bundle: nil)
    private static let summaryStoryboard = UIStoryboard(name: "Summary", bundle: nil)
    
    static func onboardingNavigationController() -> UINavigationController {
        return onboardingStoryboard.instantiateViewController(withIdentifier: "OnboardingNavigationController") as! UINavigationController
    }
    
    static func guestListViewController() -> GuestListViewController {
        return guestListStoryboard.instantiateViewController(withIdentifier: "GuestListViewController") as! GuestListViewController
    }
    
    static func RVSPSummaryViewController() -> RVSPSummaryViewController {
        return summaryStoryboard.instantiateViewController(withIdentifier: "RVSPSummaryViewController") as! RVSPSummaryViewController
    }
    
    static func RSVPDetailsViewController() -> RSVPDetailsViewController {
        return summaryStoryboard.instantiateViewController(withIdentifier: "RSVPDetailsViewController") as! RSVPDetailsViewController
    }
    
    static func addGuestsViewController() -> AddGuestsViewController {
        return guestListStoryboard.instantiateViewController(withIdentifier: "AddGuestsViewController") as! AddGuestsViewController
    }
}
