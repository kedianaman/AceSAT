//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/17/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var wordView: FlashcardView!
    @IBOutlet weak var vocabWordLabel: UILabel!
    var showingWord = true
    var word: String?
    var wordDefinition: String?
    var index = 0
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var words = VocabWords().words
  
    
    
    
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
    @IBAction func cardPanned(sender: UIPanGestureRecognizer) {
//        switch sender.state {
//        case .Began:
//            fallthrough
//        case .Changed:
//            let translation = sender.translationInView(view)
//            wordView.frame.origin.x += translation.x
//            wordView.frame.origin.y += translation.y
//            sender.setTranslation(CGPointZero, inView: view)
//        default: break
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "cardTapped")
        wordView.addGestureRecognizer(tapGesture)
        view.addSubview(wordView)
        vocabWordLabel.text = ""
        nextButton.alpha = 0.0
        nextButton.enabled = false
        backButton.alpha = 0.0
        backButton.enabled = true
    }
    
    func cardTapped() {
        if showingWord == true {
            vocabWordLabel.font = vocabWordLabel.font.fontWithSize(20)
            vocabWordLabel.text = wordDefinition
            wordView.flip()
            showingWord = false
        } else {
            vocabWordLabel.font = vocabWordLabel.font.fontWithSize(30)
            vocabWordLabel.text = word
            wordView.flip()
            showingWord = true
        }
        
    }

}