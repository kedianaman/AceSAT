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
        percentageLabel.font = UIFont.systemFontOfSize(CGFloat(ringSize * 0.3), weight: UIFontWeightUltraLight)
        percentageLabel.numberOfLines = 0
        percentageLabel.textColor = UIColor.whiteColor()
        percentageLabel.textAlignment = NSTextAlignment.Center
        
        self.addSubview(percentageLabel)
        
        if backgroundRingLayer == nil {
            backgroundRingLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer)
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.strokeColor = UIColor(white: 1.0, alpha: 0.1).CGColor
        }
        
        let backgroundRingBounds = CGRect(origin: CGPointZero, size: ringBounds.size)
        let backgroundLayerRect = CGRectInset(backgroundRingBounds, CGFloat(lineWidth / 2.0), CGFloat(lineWidth / 2.0))
        let backgroundLayerPath = UIBezierPath(ovalInRect: backgroundLayerRect)
        backgroundRingLayer.path = backgroundLayerPath.CGPath
        backgroundRingLayer.lineWidth = CGFloat(lineWidth)


        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            ringLayer.fillColor = nil
            ringLayer.strokeColor = UIColor.ace_redColor().CGColor
            ringLayer.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI / 2), CGFloat(0), CGFloat(0), CGFloat(1))
            ringLayer.strokeEnd = 0.0
            layer.addSublayer(ringLayer)
            
            ringLayer.lineCap = kCALineCapRound
            ringLayer.lineJoin = kCALineJoinRound
        }

        let innerRingBounds = CGRect(origin: CGPointZero, size: ringBounds.size)
        let ringLayerRect = CGRectInset(innerRingBounds, CGFloat(lineWidth / 2.0), CGFloat(lineWidth / 2.0))
        let ringLayerPath = UIBezierPath(ovalInRect: ringLayerRect)
        
        ringLayer.lineWidth = CGFloat(lineWidth)
        ringLayer.path = ringLayerPath.CGPath
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.ace_redGradientStartColor().CGColor, UIColor.ace_redGradientEndColor().CGColor]
            layer.addSublayer(gradientLayer)
            gradientLayer.mask = ringLayer
        }
        

        backgroundRingLayer.frame = ringBounds
        gradientLayer.frame = ringBounds
        ringLayer.frame = gradientLayer.bounds
        
        updateLayerProperties()
    }
    
    func animate() {
        let pathAnimation = CASpringAnimation(keyPath: "draw ring")
        pathAnimation.duration = 10.0
        pathAnimation.damping = 20.0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = NSValue(ringLayer.strokeEnd = 0.0)
        pathAnimation.toValue = NSValue(ringLayer.strokeEnd = CGFloat(Double(correctAnswers) / 10.0))
        self.layer.addAnimation(pathAnimation, forKey: "draw ring")
        
        
    }

    private func updateLayerProperties() {
        let ringSize = min(bounds.width, bounds.height) - 40
        let thinFont = UIFont.systemFontOfSize(ringSize * 0.4, weight: UIFontWeightLight)
        let lightFont = UIFont.systemFontOfSize(ringSize * 0.1, weight: UIFontWeightLight)
        
        let attributedText = NSMutableAttributedString(string: String(correctAnswers), attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.whiteColor()])
        attributedText.appendAttributedString(NSAttributedString(string: "\n of \(numberOfQuestions!)", attributes: [NSFontAttributeName: lightFont, NSForegroundColorAttributeName:UIColor(white: CGFloat(1.0), alpha: CGFloat(0.5)) ]))
        percentageLabel.attributedText = attributedText
    }

    
}
