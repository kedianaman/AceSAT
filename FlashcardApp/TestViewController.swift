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
    let words = VocabWords().getWordsAtIndex(0)!
    
    override func viewDidLoad() {
        navigationController?.view.window?.tintColor = UIColor(red:1.00, green:0.16, blue:0.41, alpha:1.0)
        buttons = [definition1Button, definition2Button, definition3Button, definition4Button]
        setUpAtIndex(2)
  
        
    }
    @IBAction func buttonTapped(sender: UIButton) {
        if let selectedIndex = selectedIndex {
            buttons[selectedIndex].setImage(UIImage(named: "Not Selected Circle"), forState: UIControlState.Normal)
        }
        sender.setImage(UIImage(named: "Selected Circle"), forState: UIControlState.Normal)
        selectedIndex = sender.tag
        
        
        
    }
    
    func setUpAtIndex(indexOfWord: Int) {
        let vocabWord = words.keys.array[indexOfWord]
        vocabWordTitle.text = vocabWord
//        var buttons = [definition1Button, definition2Button, definition3Button, definition4Button]
        let index = arc4random() % 4
        let label = buttons[Int(index)]
        label.setTitle(words[vocabWord], forState: UIControlState.Normal)
        for i in 0...3 {
            if i != Int(index) {
                var previousIndices = [UInt32(indexOfWord)]
                var randomIndex: UInt32 = UInt32(indexOfWord)
                while randomIndex == UInt32(indexOfWord) && previousIndices.contains(randomIndex) == true {
                    randomIndex = arc4random() % UInt32(words.count - 1)
                }
                previousIndices.append(randomIndex)
                let vocabWord = words.keys.array[Int(randomIndex)]
                buttons[i].setTitle(words[vocabWord], forState: UIControlState.Normal)
            }
        }
        
    }
}
