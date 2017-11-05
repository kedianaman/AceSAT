//
//  TestPercentageView.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 8/1/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

@IBDesignable
class TestPercentageView: UIView {
    var backgroundRingLayer: CAShapeLayer!
    var ringLayer: CAShapeLayer!
    var gradientLayer: CAGradientLayer!
    var percentageLabel = UILabel()
    var numberOfQuestions: Int?
    
    var lineWidth: Double = 10.0
    
    var correctAnswers: Int = 7 {
        didSet {
            updateLayerProperties()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let ringSize = min(bounds.width, bounds.height) - 40
        let ringBounds = CGRect(origin: CGPoint(x: (bounds.width-ringSize)/2.0, y: (bounds.height-ringSize)/2.0), size: CGSize(width: ringSize, height: ringSize))
        
        lineWidth = floor(Double(ringSize) * 0.08)
        
        percentageLabel.frame = ringBounds
        percentageLabel.font = UIFont.systemFont(ofSize: CGFloat(ringSize * 0.3), weight: UIFontWeightUltraLight)
        percentageLabel.numberOfLines = 0
        percentageLabel.textColor = UIColor.white
        percentageLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(percentageLabel)
        
        if backgroundRingLayer == nil {
            backgroundRingLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer)
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.strokeColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        }
        
        let backgroundRingBounds = CGRect(origin: CGPoint.zero, size: ringBounds.size)
        let backgroundLayerRect = backgroundRingBounds.insetBy(dx: CGFloat(lineWidth / 2.0), dy: CGFloat(lineWidth / 2.0))
        let backgroundLayerPath = UIBezierPath(ovalIn: backgroundLayerRect)
        backgroundRingLayer.path = backgroundLayerPath.cgPath
        backgroundRingLayer.lineWidth = CGFloat(lineWidth)


        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            ringLayer.fillColor = nil
            ringLayer.strokeColor = UIColor.ace_redColor().cgColor
            ringLayer.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI / 2), CGFloat(0), CGFloat(0), CGFloat(1))
            ringLayer.strokeEnd = 0.0
            layer.addSublayer(ringLayer)
            
            ringLayer.lineCap = kCALineCapRound
            ringLayer.lineJoin = kCALineJoinRound
        }

        let innerRingBounds = CGRect(origin: CGPoint.zero, size: ringBounds.size)
        let ringLayerRect = innerRingBounds.insetBy(dx: CGFloat(lineWidth / 2.0), dy: CGFloat(lineWidth / 2.0))
        let ringLayerPath = UIBezierPath(ovalIn: ringLayerRect)
        
        ringLayer.lineWidth = CGFloat(lineWidth)
        ringLayer.path = ringLayerPath.cgPath
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.ace_redGradientStartColor().cgColor, UIColor.ace_redGradientEndColor().cgColor]
            layer.addSublayer(gradientLayer)
            gradientLayer.mask = ringLayer
        }
        

        backgroundRingLayer.frame = ringBounds
        gradientLayer.frame = ringBounds
        ringLayer.frame = gradientLayer.bounds
        
        updateLayerProperties()
    }
    
    func animate() {
        let pathAnimation = CASpringAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 2.0
        pathAnimation.damping = 16.0
        
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pathAnimation.fromValue = NSValue(ringLayer.strokeEnd = 0.0)
        pathAnimation.toValue = NSValue(ringLayer.strokeEnd = CGFloat(Double(correctAnswers) / 10.0))

        ringLayer.add(pathAnimation, forKey: "strokeEnd")
        
        
    }

    fileprivate func updateLayerProperties() {
        let ringSize = min(bounds.width, bounds.height) - 40
        let thinFont = UIFont.systemFont(ofSize: ringSize * 0.4, weight: UIFontWeightLight)
        let lightFont = UIFont.systemFont(ofSize: ringSize * 0.1, weight: UIFontWeightLight)
        
        let attributedText = NSMutableAttributedString(string: String(correctAnswers), attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.white])
        attributedText.append(NSAttributedString(string: "\n of \(numberOfQuestions!)", attributes: [NSFontAttributeName: lightFont, NSForegroundColorAttributeName:UIColor(white: CGFloat(1.0), alpha: CGFloat(0.5)) ]))
        percentageLabel.attributedText = attributedText
    }

    
}
