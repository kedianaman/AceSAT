//
//  PracticeFlashcardViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class PracticeFlashcardViewController: UIViewController {
    
    var showingWord = true
    let words = VocabWords().getWordsAtIndex(3)!
    
    @IBOutlet weak var definitionWordLabel: UILabel!
    @IBOutlet weak var vocabWordLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped:")
        view.addGestureRecognizer(tapGesture)
        vocabWordLabel.text = words.keys.array.first
        definitionWordLabel.text = words[words.keys.array.first!]
        definitionlabelCenterYConstraint.constant = view.bounds.size.height/2
         navigationController?.view.window?.tintColor = UIColor(red:0.10, green:0.82, blue:0.99, alpha:1.0)
    }

    
    func viewTapped(gesture: UIGestureRecognizer) {
        if gesture.state == .Recognized {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.definitionlabelCenterYConstraint.constant = self.showingWord ? self.view.bounds.height/6 : self.view.bounds.height / 2
                self.vocabWordLabelCenterYConstraint.constant = self.showingWord ? -self.view.bounds.size.height/6 : 0
                self.view.layoutIfNeeded()
                }, completion: nil)
            
            showingWord = !showingWord
            
            
        }
    }
    

    @IBOutlet weak var vocabWordLabelCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var definitionlabelCenterYConstraint: NSLayoutConstraint!
    

}
