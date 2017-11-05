//
//  GlanceController.swift
//  AceSATWatch Extension
//
//  Created by Naman Kedia on 9/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet var wordLabel: WKInterfaceLabel!
    @IBOutlet var definitionLabel: WKInterfaceLabel!
    

    func getWordForDate(_ date: Date) -> Word {
        let seconds = date.timeIntervalSinceReferenceDate
        let hours = Int(seconds/3600)
        let wordIndex = hours % 1000
        let word = WordListManager.sharedManager.allWords[wordIndex]
        return word
        
    }
    
    override func willActivate() {
        let word = getWordForDate(Date())
        wordLabel.setText(word.word)
        definitionLabel.setText(word.definition)
    }

}
