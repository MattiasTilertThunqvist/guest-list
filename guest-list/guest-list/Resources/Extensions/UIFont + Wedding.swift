//
//  UIFont + Wedding.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

public extension UIFont {
    // Only use font size 13, 15, 17, 20 for weddingRegularFont
    class func weddingRegularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AmericanTypewriter", size: size)!
    }
    
    class func weddingLightFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AmericanTypewriter-Light", size: size)!
    }
    
    class func weddingBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AmericanTypewriter-Bold", size: size)!
    }
    
    class func preferredFontStyle(_ style: String) -> UIFont {
        switch(style) {
        case "button":
            return UIFont.weddingRegularFont(13)
        case "header":
            return UIFont.weddingRegularFont(20)
        default:
            return UIFont.weddingRegularFont(13)
        }
    }
}
