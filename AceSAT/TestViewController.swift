//
//  TestViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestButton: UIButton {
    override func intrinsicContentSize() -> CGSize {
        var size = self.titleLabel!.intrinsicContentSize()
        size.width += self.imageView!.bounds.size.width
        size.height = floor(size.height * 1.2)
        return size
    }
}

protocol TestViewControllerDelegate: class {
    func addCompleteButton(testViewController: TestViewController)
}

class TestViewController: UIViewController {

    @IBOutlet weak var vocabWordTitle: UILabel!
        
    var testQuestion: TestQuestion?
    
    weak var delegate: TestPageViewController?
    

    @IBOutlet var definitionButtons: [UIButton]!
    
    override func viewDidLoad() {
        vocabWordTitle.text = testQuestion!.word.word
        
        var definitions = testQuestion!.possibleDefinitions
        definitions.insert(testQuestion!.word.definition, atIndex: random()%definitions.count+1)
        
        for i in 0..<definitions.count {
            let button = definitionButtons[i]
            let definition = definitions[i]
            
            if definition == testQuestion?.userSelectedDefinition {
                button.setImage(UIImage(named: "SelectedButton"), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.ace_redColor(), forState: UIControlState.Normal)
            }
            else {
                button.setImage(UIImage(named: "DeselectedButton"), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

            }
            
            button.setTitle(definitions[i], forState: UIControlState.Normal)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.addCompleteButton(self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFonts()
        updateButtonPreferredMaxLayoutWidth(view.bounds.size)
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        for button in definitionButtons {
            if button == sender {
                sender.setImage(UIImage(named: "SelectedButton"), forState: UIControlState.Normal)
                sender.setTitleColor(UIColor.ace_redColor(), forState: UIControlState.Normal)
                
                testQuestion?.userSelectedDefinition = sender.titleLabel?.text
            }
            else {
                button.setImage(UIImage(named: "DeselectedButton"), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            }
        }
    }
    
    // MARK:- 
    
    func updateFonts() {
        if traitCollection.verticalSizeClass == .Compact || traitCollection.horizontalSizeClass == .Compact {
            let screenSize = UIScreen.mainScreen().bounds.size
            let titleFontSize = 44.0 / 375 * min(screenSize.width, screenSize.height)
            vocabWordTitle.font = UIFont.systemFontOfSize(titleFontSize, weight: UIFontWeightLight)
            let buttonFontSize = 24.0 / 375 * min(screenSize.width, screenSize.height)
            for button in definitionButtons {
                button.titleLabel?.font = UIFont.systemFontOfSize(buttonFontSize, weight: UIFontWeightLight)
            }
        }
    }
    
    func updateButtonPreferredMaxLayoutWidth(size: CGSize) {
        for button in definitionButtons {
            button.titleLabel?.preferredMaxLayoutWidth = size.width - button.imageView!.image!.size.width - view.layoutMargins.left*2 - 20*2 - button.titleEdgeInsets.left - button.titleEdgeInsets.right - button.imageEdgeInsets.left - button.imageEdgeInsets.right
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        updateButtonPreferredMaxLayoutWidth(size)
    }
}
