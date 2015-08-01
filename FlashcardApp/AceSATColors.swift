//
//  AceSATColors.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/29/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

extension UIColor {

    class func ace_greenColor() -> UIColor {
        return UIColor(red: (167/255.0), green: (252/255.0), blue: (50/255.0), alpha: 1.0)
    }
    
    class func ace_blueColor() -> UIColor {
        return UIColor(red: (42/255.0), green: (243/255.0), blue: (232/255.0), alpha: 1.0)
    }
    
    class func ace_redColor() -> UIColor {
        return UIColor(red: (246/255.0), green: (27/255.0), blue: (82/255.0), alpha: 1.0)
    }
}

extension CGGradientRef {
    
    class func ace_greenGradient() -> CGGradientRef {
        let startColor = UIColor(red: (183/255.0), green: 1.0, blue: 0.0, alpha: 1.0)
        let endColor = UIColor(red: (47/255.0), green: (187/255.0), blue: 0.0, alpha: 1.0)
        let colors = [startColor.CGColor, endColor.CGColor]
        return CGGradientCreateWithColors(nil, colors as CFArray, nil)!
    }
    
    class func ace_blueGradient() -> CGGradientRef {
        let startColor = UIColor(red: 0.0, green: (250/255.0), blue: (208/255.0), alpha: 1.0)
        let endColor = UIColor(red: 0.0, green: (182/255.0), blue: (219/255.0), alpha: 1.0)
        let colors = [startColor.CGColor, endColor.CGColor]
        return CGGradientCreateWithColors(nil, colors as CFArray, nil)!
    }
    
    class func ace_redGradient() -> CGGradientRef {
        let startColor = UIColor(red: 1.0, green: (50/255.0), blue: (135/255.0), alpha: 1.0)
        let endColor = UIColor(red: (225/255.0), green: 0.0, blue: (20/255.0), alpha: 1.0)
        let colors = [startColor.CGColor, endColor.CGColor]
        return CGGradientCreateWithColors(nil, colors as CFArray, nil)!
    }
    
}