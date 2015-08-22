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
    
    var indexOfView: Int?
    @IBOutlet weak var definitionWordLabel: UILabel!
    @IBOutlet weak var vocabWordLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    // Active when definition is hidden
    @IBOutlet weak var wordZeroBottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomSpaceConstraint: NSLayoutConstraint!

    // Active when showing definition
    @IBOutlet weak var definitionWordSpacingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewCenterYConstraint: NSLayoutConstraint!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var definitionWordText: String!
    var vocabWordText: String!
    
    var showingDefinition = false {
        didSet {
            updateConstraintsAndLabelAlpha()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped:")
        view.addGestureRecognizer(tapGesture)
        definitionWordLabel.text = definitionWordText
        vocabWordLabel.text = vocabWordText
        definitionWordLabel.alpha = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateConstraintsAndLabelAlpha()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({ context -> Void in
            self.updateConstraintsAndLabelAlpha()
            self.view.layoutIfNeeded()
            }, completion: nil)
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

    func updateConstraintsAndLabelAlpha() {
        let showDefinitionConstraints: [NSLayoutConstraint] = [ definitionWordSpacingConstraint, containerViewCenterYConstraint ]
        let hideDefinitionConstraints: [NSLayoutConstraint] = [ wordZeroBottomSpaceConstraint, containerViewTopSpaceConstraint, containerViewBottomSpaceConstraint ]
        
        if showingDefinition {
            NSLayoutConstraint.deactivateConstraints(hideDefinitionConstraints)
            NSLayoutConstraint.activateConstraints(showDefinitionConstraints)
        }
        else {
            NSLayoutConstraint.deactivateConstraints(showDefinitionConstraints)
            NSLayoutConstraint.activateConstraints(hideDefinitionConstraints)
        }

        definitionWordLabel.alpha = showingDefinition ? 1 : 0
        view.layoutIfNeeded()
    }
   
}
