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
    
    var lineWidth: Double = 10.0
    
    var percentage: Double = 80.0 {
        didSet {
            updateLayerProperties()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let ringSize = min(bounds.width, bounds.height)
        let ringBounds = CGRect(origin: CGPoint(x: (bounds.width-ringSize)/2.0, y: (bounds.height-ringSize)/2.0), size: CGSize(width: ringSize, height: ringSize))
        
        lineWidth = floor(Double(ringSize) * 0.08)
        
        percentageLabel.frame = ringBounds
        percentageLabel.font = UIFont.systemFontOfSize(CGFloat(ringSize * 0.3), weight: UIFontWeightUltraLight)
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
            ringLayer.lineWidth = CGFloat(lineWidth)
            ringLayer.fillColor = nil
            ringLayer.strokeColor = UIColor.ace_redColor().CGColor
            ringLayer.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI / 2), CGFloat(0), CGFloat(0), CGFloat(1))
            layer.addSublayer(ringLayer)
            
            ringLayer.lineCap = kCALineCapRound
            ringLayer.lineJoin = kCALineJoinRound
        }

        let innerRingBounds = CGRect(origin: CGPointZero, size: ringBounds.size)
        let ringLayerRect = CGRectInset(innerRingBounds, CGFloat(lineWidth / 2.0), CGFloat(lineWidth / 2.0))
        let ringLayerPath = UIBezierPath(ovalInRect: ringLayerRect)
        
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
    
    private func updateLayerProperties() {
        if ringLayer != nil {
            ringLayer.strokeEnd = CGFloat(percentage / 100.0)
        }
        percentageLabel.text = String(Int(percentage)) + "%"
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
