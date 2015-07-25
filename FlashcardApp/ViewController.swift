//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/17/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var wordView: FlashcardView!
    @IBOutlet weak var vocabWordLabel: UILabel!
    var showingWord = true
    var word: String?
    var wordDefinition: String?
    var index = 0
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    let speechSynthesizer = AVSpeechSynthesizer()
    var words = VocabWords().words
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var indexWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "cardTapped")
        wordView.addGestureRecognizer(tapGesture)
        view.addSubview(wordView)
        speechButton.enabled = false
        speechButton.alpha = 0.0
        vocabWordLabel.text = ""
        nextButton.alpha = 0.0
        nextButton.enabled = false
        backButton.alpha = 0.0
        backButton.enabled = true
        indexWordLabel.text = ""
        indexWordLabel.alpha = 0.6
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

        sender.enabled = false
        sender.removeFromSuperview()
        word = words.keys.array[index]
        wordDefinition = words[word!]
        vocabWordLabel.text = word
        showingWord = true
        nextButton.enabled = true
        nextButton.alpha = 1.0
        backButton.enabled = true
        backButton.alpha = 1.0
        speechButton.enabled = true
        speechButton.alpha = 1.0
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
        vocabWordLabel.font = vocabWordLabel.font.fontWithSize(30)
//        wordView.shadowOffSet = CGFloat(index)

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
//        wordView.shadowOffSet = CGFloat(index)
    }

    @IBAction func speak(sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: word!)
        speechSynthesizer.speakUtterance(speechUtterance)
    }
 
    
    func cardTapped() {
        if showingWord == true {
            speechButton.enabled = false
            speechButton.alpha = 0.0
            vocabWordLabel.font = vocabWordLabel.font.fontWithSize(20)
            vocabWordLabel.text = wordDefinition
            wordView.flip()
            showingWord = false
        } else {
            speechButton.enabled = true
            speechButton.alpha = 1.0
            vocabWordLabel.font = vocabWordLabel.font.fontWithSize(30)
            vocabWordLabel.text = word
            wordView.flip()
            showingWord = true
        }
        
    }

}