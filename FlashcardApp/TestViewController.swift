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
    
    @IBOutlet weak var definition1Button: UIButton!
    @IBOutlet weak var definition2Button: UIButton!
    @IBOutlet weak var definition3Button: UIButton!
    @IBOutlet weak var definition4Button: UIButton!
    var buttons = [UIButton]()
    var selectedIndex: Int?
    var indexOfCorrectDefinition = arc4random() % 4
    var viewControllerIndex: Int? 
    var vocabWordText: String?
    var button1Text: String?
    var button2Text: String?
    var button3Text: String?
    var button4Text: String?
    var buttonTexts = [String?]()

    
    override func viewDidLoad() {
        buttons = [definition1Button, definition2Button, definition3Button, definition4Button]
        vocabWordTitle.text = vocabWordText!
        
        for i in 0...3 {
            buttons[i].setImage(UIImage(named: "Not Selected Circle"), forState: UIControlState.Normal)
            buttons[i].setTitle(buttonTexts[i], forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        if let currentSelectedIndex = selectedIndex {
            buttons[currentSelectedIndex].setImage(UIImage(named: "Not Selected Circle"), forState: UIControlState.Normal)
            if selectedIndex == sender.tag {
                selectedIndex = nil
                return
            }
        }
        sender.setImage(UIImage(named: "Selected Circle"), forState: UIControlState.Normal)
        selectedIndex = sender.tag
        
    }
    
    func isCorrect() -> Bool? {
        if let selectedIndex = selectedIndex {
            if selectedIndex == Int(indexOfCorrectDefinition) {
                return true
            } else {
                return false
            }
        }
        return nil
    }
    
    func setUpAtIndex(indexOfWord: Int, words: [String: String]) {
        let vocabWord = words.keys.array[indexOfWord]
        vocabWordText = vocabWord
        buttonTexts = [button1Text, button2Text, button3Text, button4Text]
        // set definition of correct word to button text at random index
        buttonTexts[Int(indexOfCorrectDefinition)] = words[vocabWord]
        var previousIndices = [UInt32(indexOfWord)]
        for i in 0...3 {
            // if the index is not of the correct definition, set it to a random definition everytime
            if i != Int(indexOfCorrectDefinition) {
                var randomIndex: UInt32 = UInt32(indexOfWord)
                while randomIndex == UInt32(indexOfWord) || previousIndices.contains(randomIndex) == true {
                    randomIndex = arc4random() % UInt32(words.count - 1)
                }
                previousIndices.append(randomIndex)
                let currentVocabWord = words.keys.array[Int(randomIndex)]
                buttonTexts[i] = words[currentVocabWord]
            }
        }
        
    }
}
