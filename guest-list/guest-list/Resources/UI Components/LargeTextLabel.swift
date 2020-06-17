//
//  LargeTextLabel.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class LargeTextLabel: UILabel {
        
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
        numberOfLines = 500 //Allow unlimited
        textColor = .weddingGray
        font = .weddingRegularFont(textSize: .large)
    }
}
