//
//  TestViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var vocabWordTitle: UILabel!
    
    var viewControllerIndex: Int?
    
    var testQuestion: TestQuestion?

    @IBOutlet var definitionButtons: [UIButton]!
    
    override func viewDidLoad() {
        vocabWordTitle.text = testQuestion!.word.word
        
        var definitions = testQuestion!.possibleDefinitions
        definitions.insert(testQuestion!.word.definition, atIndex: random()%definitions.count)
        
        for i in 0..<definitions.count {
            let button = definitionButtons[i]
            let definition = definitions[i]
            
            if definition == testQuestion?.userSelectedDefinition {
                button.setImage(UIImage(named: "SelectedButton"), forState: UIControlState.Normal)
            }
            else {
                button.setImage(UIImage(named: "DeselectedButton"), forState: UIControlState.Normal)
            }
            
            button.setTitle(definitions[i], forState: UIControlState.Normal)
        }
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        for button in definitionButtons {
            if button == sender {
                sender.setImage(UIImage(named: "SelectedButton"), forState: UIControlState.Normal)
                testQuestion?.userSelectedDefinition = sender.titleLabel?.text
            }
            else {
                button.setImage(UIImage(named: "DeselectedButton"), forState: UIControlState.Normal)
            }
        }
    }
}
