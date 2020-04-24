//
//  UIFont + Wedding.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

public extension UIFont {
    
    enum TextSize: CGFloat {
        case small = 13
        case medium = 15
        case large = 17
        case extraLarge = 20
    }
    
    class func weddingRegularFont(textSize: TextSize) -> UIFont {
        return UIFont(name: "AmericanTypewriter", size: textSize.rawValue)!
    }
    
    class func weddingLightFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AmericanTypewriter-Light", size: size)!
    }
    
    class func weddingBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AmericanTypewriter-Bold", size: size)!
    }
}
