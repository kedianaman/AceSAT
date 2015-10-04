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
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let randomListIndex = random() % 100
        let randomWordIndex = random() % 10
        let wordList = WordListManager.sharedManager.wordListAtIndex(randomListIndex)
        let word = wordList[randomWordIndex]
        
        wordLabel.setText(word.word)
        definitionLabel.setText(word.definition)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
