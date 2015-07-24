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
    }

    
    
    @IBAction func gameStarted(sender: UIButton) {
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
        
    }
    
    @IBAction func next() {
        wordView.next(true)
        index++
        if index > words.count - 1 {
            index = 0
        }
        word = words.keys.array[index]
        wordDefinition = words[word!]
        vocabWordLabel.text = word
        showingWord = true
        
    }
    @IBAction func back() {
        index--
        if index >= 0 {
            wordView.next(false)
            word = words.keys.array[index]
            wordDefinition = words[word!]
            vocabWordLabel.text = word
            showingWord = true
        } else {
            
        }
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