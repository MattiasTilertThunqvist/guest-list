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
    private static let pageScrollStoryboard = UIStoryboard(name: "PageScroll", bundle: nil)
    private static let guestListStoryboard = UIStoryboard(name: "GuestList", bundle: nil)
    private static let summaryStoryboard = UIStoryboard(name: "Summary", bundle: nil)
    
    static func pageViewController() -> PageViewController {
        return pageScrollStoryboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
    }
    
    static func onboardingNavigationController() -> UINavigationController {
        return onboardingStoryboard.instantiateViewController(withIdentifier: "OnboardingNavigationController") as! UINavigationController
    }
    
    static func guestListViewController() -> GuestListViewController {
        return guestListStoryboard.instantiateViewController(withIdentifier: "GuestListViewController") as! GuestListViewController
    }
    
    static func RVSPSummaryViewController() -> RsvpSummaryViewController {
        return summaryStoryboard.instantiateViewController(withIdentifier: "RVSPSummaryViewController") as! RsvpSummaryViewController
    }
    
    static func rsvpDetailsViewController() -> RsvpDetailsViewController {
        return summaryStoryboard.instantiateViewController(withIdentifier: "RsvpDetailsViewController") as! RsvpDetailsViewController
    }
    
    static func addGuestsViewController() -> ManageGuestsViewController {
        return guestListStoryboard.instantiateViewController(withIdentifier: "ManageGuestsViewController") as! ManageGuestsViewController
    }
    
    static func pickerViewControlelr() -> PickerViewController {
        return guestListStoryboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
    }
}
