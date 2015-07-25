//
//  FlashcardView.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/17/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class FlashcardView: UIView {
    
    func flip() {
        UIView.transitionWithView(self, duration: 0.3, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
            print("flipped")
            }, completion: nil)
        
    }
    func next(yes: Bool, shadowOffSet: CGFloat) {
        UIView.transitionWithView(self, duration: 0.3, options: yes ? UIViewAnimationOptions.TransitionCurlUp : UIViewAnimationOptions.TransitionCurlDown, animations: { () -> Void in
            self.layer.shadowOffset = CGSizeMake(shadowOffSet, shadowOffSet)
            }, completion: nil)
    }
//    var shadowOffSet: CGFloat? {
//        didSet {
//            self.layer.shadowOffset = CGSizeMake(shadowOffSet!, shadowOffSet!)
//	        }
//    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 0)
        self.layer.shadowOpacity = 0.3
    }
 

}
