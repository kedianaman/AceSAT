//
//  RoundGradientButton.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/30/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class RoundGradientButton: UIButton {

    var gradient: CGGradient?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setTitleColor(UIColor.black, for: UIControl.State())
        self.setTitleShadowColor(UIColor(white: 1.0, alpha: 0.2), for: UIControl.State())
        self.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateBackgroundImage()
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: bounds.size.height * 0.225, weight: UIFont.Weight.light)
    }
 
    fileprivate func updateBackgroundImage() {
        if gradient == nil {
            return;
        }
        
        let size = CGSize(width: round(bounds.size.width), height: round(bounds.size.height))
        
        let currentImage = self.backgroundImage(for: UIControl.State())
        if currentImage?.size == size {
            return
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let roundPath = UIBezierPath(ovalIn: bounds)
        context?.addPath(roundPath.cgPath)
        context?.clip()
        
        context?.drawLinearGradient(gradient!, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIColor(white: 0.0, alpha: 0.2).setFill()
        UIBezierPath(rect: bounds).fill()
        
        let selectedBackgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: UIControl.State())
        self.setBackgroundImage(selectedBackgroundImage, for: .highlighted)
        self.setBackgroundImage(selectedBackgroundImage, for: .selected)
    }
    
    fileprivate func updateScaleForHighlightedState() {
        if self.isHighlighted {
            if (self.transform.isIdentity) {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    }, completion: nil)
            }
        }
        else {
            if (self.transform.isIdentity == false) {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    self.transform = CGAffineTransform.identity
                    }, completion: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateScaleForHighlightedState()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateScaleForHighlightedState()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateScaleForHighlightedState()
    }
}
