//
//  TestViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestButton: UIButton {
    override var intrinsicContentSize : CGSize {
        var size = self.titleLabel!.intrinsicContentSize
        size.width += self.imageView!.bounds.size.width
        size.height = floor(size.height * 1.2)
        return size
    }
}

protocol TestViewControllerDelegate: class {
    func addCompleteButton(_ testViewController: TestViewController)
}

class TestViewController: UIViewController {

    @IBOutlet weak var vocabWordTitle: UILabel!
        
    var testQuestion: TestQuestion?
    
    weak var delegate: TestPageViewController?
    

    @IBOutlet var definitionButtons: [UIButton]!
    
    override func viewDidLoad() {
        vocabWordTitle.text = testQuestion!.word.word
        
        var definitions = testQuestion!.possibleDefinitions
        definitions.insert(testQuestion!.word.definition, at: Int(arc4random())%definitions.count+1)
        
        for i in 0..<definitions.count {
            let button = definitionButtons[i]
            let definition = definitions[i]
            
            if definition == testQuestion?.userSelectedDefinition {
                button.setImage(UIImage(named: "SelectedButton"), for: UIControl.State())
                button.setTitleColor(UIColor.ace_redColor(), for: UIControl.State())
            }
            else {
                button.setImage(UIImage(named: "DeselectedButton"), for: UIControl.State())
                button.setTitleColor(UIColor.white, for: UIControl.State())

            }
            
            button.setTitle(definitions[i], for: UIControl.State())
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.addCompleteButton(self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFonts()
        updateButtonPreferredMaxLayoutWidth(view.bounds.size)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        for button in definitionButtons {
            if button == sender {
                sender.setImage(UIImage(named: "SelectedButton"), for: UIControl.State())
                sender.setTitleColor(UIColor.ace_redColor(), for: UIControl.State())
                
                testQuestion?.userSelectedDefinition = sender.titleLabel?.text
            }
            else {
                button.setImage(UIImage(named: "DeselectedButton"), for: UIControl.State())
                button.setTitleColor(UIColor.white, for: UIControl.State())
            }
        }
    }
    
    // MARK:- 
    
    func updateFonts() {
        if traitCollection.verticalSizeClass == .compact || traitCollection.horizontalSizeClass == .compact {
            let screenSize = UIScreen.main.bounds.size
            let titleFontSize = 44.0 / 375 * min(screenSize.width, screenSize.height)
            vocabWordTitle.font = UIFont.systemFont(ofSize: titleFontSize, weight: UIFont.Weight.light)
            let buttonFontSize = 24.0 / 375 * min(screenSize.width, screenSize.height)
            for button in definitionButtons {
                button.titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize, weight: UIFont.Weight.light)
            }
        }
    }
    
    func updateButtonPreferredMaxLayoutWidth(_ size: CGSize) {
//        for button in definitionButtons {
//            button.titleLabel?.preferredMaxLayoutWidth = (size.width - button.imageView!.image!.size.width - view.layoutMargins.left*2) - 20*2 - button.titleEdgeInsets.left - button.titleEdgeInsets.right - button.imageEdgeInsets.left - button.imageEdgeInsets.right
//        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateButtonPreferredMaxLayoutWidth(size)
    }
}
