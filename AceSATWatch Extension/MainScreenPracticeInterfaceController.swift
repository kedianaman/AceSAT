//
//  MainScreenPracticeInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 9/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class MainScreenPracticeInterfaceController: WKInterfaceController {

    let temporaryWordsDict = ["Abhor":"hate",
        "Bigot":"narrow-minded, prejudiced person",
        "Counterfeit":"fake; false",
        "Enfranchise":"give voting rights",
        "Hamper":"hinder; obstruct",
        "Kindle":"to start a fire",
        "Noxious":"harmful; poisonous; lethal",
        "Placid":"calm; peaceful",
        "Remuneration":"payment for work done",
        "Talisman":"lucky charm"]
    var wordDict: [Dictionary<String, String>] = []
    var identifiers = [String]()

    @IBAction func practiceButtonPressed() {
        
        presentControllerWithNames(identifiers, contexts: wordDict)
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        for (word, definition) in temporaryWordsDict {
            wordDict.append([word:definition])
        }
        
        for _ in 0..<10 {
            identifiers.append("PracticeIdentifier")
        }
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
