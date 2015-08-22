//
//  RoundGradientButton.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/30/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class RoundGradientButton: UIButton {

    var gradient: CGGradientRef?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.setTitleShadowColor(UIColor(white: 1.0, alpha: 0.2), forState: .Normal)
        self.titleLabel?.shadowOffset = CGSizeMake(0, 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateBackgroundImage()
        
        self.titleLabel?.font = UIFont.systemFontOfSize(bounds.size.height * 0.225, weight: UIFontWeightLight)
    }
 
    private func updateBackgroundImage() {
        if gradient == nil {
            return;
        }
        
        let size = CGSizeMake(round(bounds.size.width), round(bounds.size.height))
        
        let currentImage = self.backgroundImageForState(.Normal)
        if currentImage?.size == size {
            return
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let roundPath = UIBezierPath(ovalInRect: bounds)
        CGContextAddPath(context, roundPath.CGPath)
        CGContextClip(context)
        
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0, size.height), CGGradientDrawingOptions(rawValue: 0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIColor(white: 0.0, alpha: 0.2).setFill()
        UIBezierPath(rect: bounds).fill()
        
        let selectedBackgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, forState: .Normal)
        self.setBackgroundImage(selectedBackgroundImage, forState: .Highlighted)
        self.setBackgroundImage(selectedBackgroundImage, forState: .Selected)
    }
    
    private func updateScaleForHighlightedState() {
        if self.highlighted {
            if (CGAffineTransformIsIdentity(self.transform)) {
                UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    }, completion: nil)
            }
        }
        else {
            if (CGAffineTransformIsIdentity(self.transform) == false) {
                UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                    self.transform = CGAffineTransformIdentity
                    }, completion: nil)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        updateScaleForHighlightedState()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        updateScaleForHighlightedState()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        updateScaleForHighlightedState()
    }
}
