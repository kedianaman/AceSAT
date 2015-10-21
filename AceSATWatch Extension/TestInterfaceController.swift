//
//  TestInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/4/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class TestInterfaceController: WKInterfaceController {
    
    @IBOutlet var definition1Button: WKInterfaceButton!
    @IBOutlet var definition2Button: WKInterfaceButton!
    @IBOutlet var definition3Button: WKInterfaceButton!
    @IBOutlet var definition4Button: WKInterfaceButton!
    
    @IBOutlet var definition1SelectedImage: WKInterfaceImage!
    @IBOutlet var definition2SelectedImage: WKInterfaceImage!
    @IBOutlet var definition3SelectedImage: WKInterfaceImage!
    @IBOutlet var definition4SelectedImage: WKInterfaceImage!
    
    @IBOutlet var definition1Label: WKInterfaceLabel!
    @IBOutlet var definition2Label: WKInterfaceLabel!
    @IBOutlet var definition3Label: WKInterfaceLabel!
    @IBOutlet var definition4Label: WKInterfaceLabel!
    
    @IBOutlet var wordLabel: WKInterfaceLabel!
    
    var definitionButtons = [WKInterfaceButton]()
    var definitionSelectedImages = [WKInterfaceImage]()
    var definitionLabels = [WKInterfaceLabel]()
    
    var presentedDefinitions = [String]()
    
    var testQuestion: TestQuestion?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        testQuestion = context as? TestQuestion        
        wordLabel.setTextColor(UIColor.ace_redColor())
        wordLabel.setText(testQuestion?.word.word)
        
        definitionButtons = [definition1Button, definition2Button, definition3Button, definition4Button]
        definitionSelectedImages = [definition1SelectedImage, definition2SelectedImage, definition3SelectedImage, definition4SelectedImage]
        definitionLabels = [definition1Label, definition2Label, definition3Label, definition4Label]

        presentedDefinitions = testQuestion!.possibleDefinitions
        presentedDefinitions.insert(testQuestion!.word.definition, atIndex: random() % 4)
        for i in 0..<presentedDefinitions.count {
            definitionLabels[i].setText(presentedDefinitions[i])
            definitionSelectedImages[i].setTintColor(UIColor(white: 0.3, alpha: 1.0))
        }
    }

    func updateButtonStates() {
        let selectedIndex = testQuestion!.userSelectedDefinition != nil ? presentedDefinitions.indexOf(testQuestion!.userSelectedDefinition!) : -1
        for i in 0..<definitionButtons.count {
            if i == selectedIndex {
                definitionLabels[i].setTextColor(UIColor.ace_redColor())
                definitionSelectedImages[i].setTintColor(UIColor.ace_redColor())
            }
            else {
                definitionLabels[i].setTextColor(UIColor.whiteColor())
                definitionSelectedImages[i].setTintColor(UIColor(white: 0.3, alpha: 1.0))
            }
        }
    }
    
    @IBAction func definition1ButtonTapped() {
        testQuestion!.userSelectedDefinition = presentedDefinitions[0]
        updateButtonStates()
    }
    
    @IBAction func definition2ButtonTapped() {
        testQuestion!.userSelectedDefinition = presentedDefinitions[1]
        updateButtonStates()
    }

    @IBAction func definition3ButtonTapped() {
        testQuestion!.userSelectedDefinition = presentedDefinitions[2]
        updateButtonStates()
    }
    
    @IBAction func definition4ButtonTapped() {
        testQuestion!.userSelectedDefinition = presentedDefinitions[3]
        updateButtonStates()
    }
}
