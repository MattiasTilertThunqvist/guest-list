//
//  LargeStickyButton.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-27.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class LargeStickyButton: UIButton {
    
    // MARK: Properties
    
    let buttonHeight = CGFloat(46)
    let buttonWidth: CGFloat = {
        let space = CGFloat(66)
        return UIScreen.main.bounds.width - space
    }()
    let email = "email"
    var useIcon = ""
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        let iconSize = CGFloat(20)
        image.frame.size.width = iconSize
        image.frame.size.height = iconSize
        image.frame.origin.y = (buttonHeight - iconSize) / 2
        image.frame.origin.x = 16
        return image
    }()
    
    public enum ColorScheme{
        case whiteOnGold
        case whiteOnTransparent
        case whiteOnRed
        case email
    }
    
    public var colorScheme = ColorScheme.whiteOnGold {
        
        didSet {
            switch colorScheme {
            case .whiteOnGold:
                setTitleColor(.weddingWhite, for: .normal)
                backgroundColor = .weddingGold
            case .whiteOnTransparent:
                setTitleColor(.weddingWhite, for: .normal)
                backgroundColor = UIColor.weddingBlack.withAlphaComponent(0.4)
            case .whiteOnRed:
                setTitleColor(.weddingWhite, for: .normal)
                backgroundColor = .weddingRed
            case .email:
                setTitleColor(.weddingWhite, for: .normal)
                backgroundColor = .weddingGold
                useIcon = email
            }
        }
    }
    
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
    
    // MARK: Override
    
    override open func layoutSubviews() {
        super.layoutSubviews()
                
        if useIcon == email {
            icon.image = #imageLiteral(resourceName: "email-white")
            addSubview(icon)
        }
    }
    
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.weddingRegularFont(12)
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = false
        layer.cornerRadius = buttonHeight / 2
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonHeight)
        addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonWidth)
        addConstraint(widthConstraint)
        
        setNeedsLayout()
    }
}
