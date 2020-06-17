//
//  CircleView.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-06-08.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    // MARK: Properties
    
    private var currentValue: Double = 0
    lazy private var circleSize: CGFloat = {
        let width = frame.size.width / 2
        let height = frame.size.height / 2
        var size = min(width, height)
        let margin = size * 0.15
        return size - margin
    }()
    
    // MARK: Views
    
    private let trackLayer = CAShapeLayer()
    private let circleLayer = CAShapeLayer()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        setup()
    }
    
    private func setup() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(circleLayer)
        
        // Track layer
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.weddingGold.withAlphaComponent(0.2).cgColor
        trackLayer.lineWidth = circleSize * 0.05
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: circleSize, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.position = center
        
        // Animation layers
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.weddingGold.cgColor
        circleLayer.lineWidth = circleSize * 0.09
        circleLayer.lineCap = .round
        circleLayer.strokeEnd = 0
        
        circleLayer.shadowColor = UIColor.weddingGold.cgColor
        circleLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        circleLayer.shadowOpacity = 0.7
        circleLayer.shadowRadius = 3
        
        circleLayer.path = circularPath.cgPath
        circleLayer.position = center
        circleLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        // Stack View
        let stackViewSize = circleSize * 0.9
        stackView.frame.size = CGSize(width: stackViewSize, height: stackViewSize)
        stackView.center = center
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.contentMode = .scaleToFill
        stackView.axis = .vertical
        addSubview(stackView)
        
        // Title Label
        titleLabel.font = .weddingRegularFont(stackViewSize * 0.5)
        titleLabel.textColor = .weddingGold
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        stackView.addArrangedSubview(titleLabel)
        
        // Sub Title Label
        subTitleLabel.font = .weddingRegularFont(stackViewSize * 0.3)
        subTitleLabel.textColor = .weddingGold
        subTitleLabel.textAlignment = .center
        subTitleLabel.backgroundColor = .clear
        stackView.addArrangedSubview(subTitleLabel)
    }
    
    func setTitle(to text: String) {
        titleLabel.text = text
    }
    
    func setSubTitle(to text: String) {
        subTitleLabel.text = text
    }
    
    func animate(withTimeinterval timeInterval: Double = 1.0, toValue: Double) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = toValue
        basicAnimation.duration = 1
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        circleLayer.add(basicAnimation, forKey: "")
        
        let timeInterval = timeInterval / toValue
        
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            if self.currentValue < toValue {
                self.currentValue += 1
            } else {
                self.currentValue -= 1
            }
                        
            if self.currentValue == toValue {
                timer.invalidate()
            }
        }
    }
}
