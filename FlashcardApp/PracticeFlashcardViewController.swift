//
//  PracticeFlashcardViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class PracticeFlashcardViewController: UIViewController {
    
    var showingDefinition = false
    var indexOfView: Int? 
    @IBOutlet weak var definitionWordLabel: UILabel!
    @IBOutlet weak var vocabWordLabel: UILabel!
    @IBOutlet weak var vocabWordLabelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var definitionlabelCenterYConstraint: NSLayoutConstraint!
    
    var definitionWordText: String!
    var vocabWordText: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped:")
        view.addGestureRecognizer(tapGesture)
        definitionlabelCenterYConstraint.constant = view.bounds.size.height/2
        definitionWordLabel.text = definitionWordText
        vocabWordLabel.text = vocabWordText
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        definitionlabelCenterYConstraint.constant = showingDefinition ? size.height/6 : size.height / 2
        vocabWordLabelCenterYConstraint.constant = showingDefinition ? -size.height/6 : 0
    }

    
    func viewTapped(gesture: UIGestureRecognizer) {
        if gesture.state == .Recognized {
            showingDefinition = !showingDefinition
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.definitionlabelCenterYConstraint.constant = self.showingDefinition ? self.view.bounds.height/6 : self.view.bounds.height / 2
                self.vocabWordLabelCenterYConstraint.constant = self.showingDefinition ? -self.view.bounds.size.height/6 : 0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    

   
}
