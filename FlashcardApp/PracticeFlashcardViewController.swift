//
//  PracticeFlashcardViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit
import AVFoundation

class PracticeFlashcardViewController: UIViewController {
    
    var showingDefinition = false {
        didSet {
            updateLabelConstraints(view.bounds.size)
        }
    }
    
    var indexOfView: Int? 
    @IBOutlet weak var definitionWordLabel: UILabel!
    @IBOutlet weak var vocabWordLabel: UILabel!
    @IBOutlet weak var vocabWordLabelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var definitionlabelCenterYConstraint: NSLayoutConstraint!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var definitionWordText: String!
    var vocabWordText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped:")
        view.addGestureRecognizer(tapGesture)
        definitionlabelCenterYConstraint.constant = view.bounds.size.height/2
        definitionWordLabel.text = definitionWordText
        vocabWordLabel.text = vocabWordText
        definitionWordLabel.alpha = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelConstraints(view.bounds.size)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        updateLabelConstraints(size)
    }
    
    func speakWord() {
        let speechUtterance = AVSpeechUtterance(string: vocabWordText)
        speechSynthesizer.speakUtterance(speechUtterance)
    }
        
    func viewTapped(gesture: UIGestureRecognizer) {
        if gesture.state == .Recognized {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.showingDefinition = !self.showingDefinition
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    

    func updateLabelConstraints(size: CGSize) {
        if definitionlabelCenterYConstraint != nil {
            definitionlabelCenterYConstraint.constant = showingDefinition ? size.height/6 : size.height / 2
            vocabWordLabelCenterYConstraint.constant = showingDefinition ? -size.height/6 : 0
            definitionWordLabel.alpha = showingDefinition ? 1 : 0
        }
    }
   
}
