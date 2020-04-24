//
//  WeddingSegmentedControl.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class WeddingSegmentedControl: UISegmentedControl {

    // MARK: Init
    
    public init() {
        super.init(frame: .zero)
        setUp()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    // MARK: View
    
    func setUp() {
        backgroundColor = .weddingGold
        
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.weddingWhite,
                                NSAttributedString.Key.font: UIFont.weddingRegularFont(textSize: .medium)],
                                for: .normal)
        
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.weddingGold,
                                NSAttributedString.Key.font: UIFont.weddingRegularFont(textSize: .medium)],
                                for: .selected)
    }
}
