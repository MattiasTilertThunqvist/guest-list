//
//  UINavigationController + Wedding.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    func transparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.tintColor = UIColor.weddingGray
        navigationBar.topItem?.title = ""
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.weddingGray,
            NSAttributedString.Key.font: UIFont.weddingRegularFont(17)
        ]
    }
}
