//
//  BoxButton.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class BoxButton: UIButton {
    
    // MARK: Properties
    
    let inset = CGFloat(16)
    let buttonHeight = CGFloat(46)
    let buttonWidth: CGFloat = {
        let screenWidth = UIScreen.main.bounds.size.width
        let inset = CGFloat(24)
        return screenWidth / 2 - inset
    }()
    
    public enum ColorScheme {
        case blackOnTransparent
        case whiteOnTransparent
    }
    
    public var colorScheme = ColorScheme.blackOnTransparent {
        didSet {
            switch colorScheme {
            case .blackOnTransparent:
                backgroundColor = UIColor.clear
                setTitleColor(UIColor.weddingBlack, for: .normal)
            case .whiteOnTransparent:
                backgroundColor = UIColor.clear
                setTitleColor(UIColor.weddingWhite, for: .normal)
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
    
    
    // MARK: - Overrides
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + inset * 4.0, height: size.height)
    }
    
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(.weddingGray, for: .normal)
        titleLabel?.font = .weddingRegularFont(textSize: .small)
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = false
        
        layer.borderColor = UIColor.weddingLightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        
        tintColor = .lightGray
        setImage(#imageLiteral(resourceName: "down-arrow-lightgray"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 15)
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonHeight)
        addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonWidth)
        addConstraint(widthConstraint)
        
        setNeedsLayout()
    }
}
