//
//  LargeTextField.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-25.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class LargeTextField: UITextField {
    
    // MARK: Properties
    
    private let animationDuration = 0.3
    
    private let textFieldHeight = CGFloat(46)
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .weddingGray
        label.font = .weddingRegularFont(textSize: .small)
        let inset = CGFloat(7)
        label.frame.size.height = 15
        label.frame.size.width = 200
        label.frame.origin.x = inset
        return label
    }()
    
    /// When input is not valid the background color is set to red. If it's valid, background color is set to default. 
    var inputIsValid: Bool = true {
        willSet {
            if newValue {
                backgroundColor = .white
            } else {
                backgroundColor = .weddingRed
            }
        }
    }

    // MARK: Init
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        insertSubview(descriptionLabel, at: 0)
    }
    
    override var placeholder: String? {
        willSet {
            descriptionLabel.text = newValue
        }
    }
    
    // MARK: View
    
    private func setup() {
        delegate = self
        textColor = .weddingGray
        tintColor = .weddingGray
        font = .weddingRegularFont(textSize: .medium)
        layer.borderColor = UIColor.weddingLightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        descriptionLabel.text = placeholder
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: textFieldHeight)
        addConstraint(heightConstraint)
    }
    
    func showLabel() {
        UIView.animate(withDuration: animationDuration) {
            self.descriptionLabel.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(-15))
        }
    }
    
    func hideLabel() {
        UIView.animate(withDuration: animationDuration) {
            self.descriptionLabel.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(0))
        }
    }
}

// MARK: UITextFieldDelegate

extension LargeTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showLabel()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let text = textField.text, text == "" {
            hideLabel()
        }
    }
}
