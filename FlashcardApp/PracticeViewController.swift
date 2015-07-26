//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/17/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit
import AVFoundation

class PracticeViewController: UIViewController {


    @IBOutlet weak var wordView: FlashcardView!
    @IBOutlet weak var vocabWordLabel: UILabel!
    var showingWord = true
    var word: String?
    var wordDefinition: String?
    var index = 0
    var words = VocabWords().getWordsAtIndex(5)!
    @IBOutlet weak var indexWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.window?.tintColor = UIColor(red:0.10, green:0.82, blue:0.99, alpha:1.0)
        let tapGesture = UITapGestureRecognizer(target: self, action: "cardTapped")
        wordView.addGestureRecognizer(tapGesture)
        view.addSubview(wordView)
        vocabWordLabel.text = ""
        indexWordLabel.text = ""
        indexWordLabel.alpha = 0.6
        
        let test = VocabWords().getWordsAtIndex(0)
        print(test)
        
    }

    
    @IBAction func cardSwiped(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizerDirection.Left {
            next()
        } else if gesture.direction == UISwipeGestureRecognizerDirection.Right {
            back()
        }
        
    }
    
    @IBAction func gameStarted(sender: UIButton) {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "cardSwiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "cardSwiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        self.navigationController?.barHideOnSwipeGestureRecognizer.requireGestureRecognizerToFail(swipeLeft)
        self.navigationController?.barHideOnSwipeGestureRecognizer.requireGestureRecognizerToFail(swipeRight)

        sender.enabled = false
        sender.removeFromSuperview()
        word = words.keys.array[index]
        wordDefinition = words[word!]
        vocabWordLabel.text = word
        showingWord = true
        indexWordLabel.text = "\(index + 1) of \(words.count)"
    }
    
    @IBAction func next() {
        index++
        print(index)
        if index > words.count - 1 {
            index = 0
        }
        wordView.next(true, shadowOffSet: CGFloat(index))
        indexWordLabel.text = "\(index + 1) of \(words.count)"
        word = words.keys.array[index]
        wordDefinition = words[word!]
        vocabWordLabel.text = word
        showingWord = true
        vocabWordLabel.font = vocabWordLabel.font.fontWithSize(100)
    }
    
    @IBAction func back() {
        index--
        if index < 0 {
            index = words.count - 1
        }
        word = words.keys.array[index]
        wordDefinition = words[word!]
        vocabWordLabel.text = word
        showingWord = true
        indexWordLabel.text = "\(index + 1) of \(words.count)"
        wordView.next(false, shadowOffSet: CGFloat(index))
    }
    
    func cardTapped() {
        if showingWord == true {
            vocabWordLabel.font = vocabWordLabel.font.fontWithSize(37)
            vocabWordLabel.text = wordDefinition
            wordView.flip()
            showingWord = false
        } else {
            vocabWordLabel.font = vocabWordLabel.font.fontWithSize(100)
            vocabWordLabel.text = word
            wordView.flip()
            showingWord = true
        }
        
    }

}