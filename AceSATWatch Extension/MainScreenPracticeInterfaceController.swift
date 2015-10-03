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

    
    
    let wordList = WordListManager.sharedManager.wordListAtIndex(1)
    

    @IBAction func practiceButtonPressed() {
        let contexts = getContextsFromWordList(wordList)
        let identifiers = getIdentifiers()
        presentControllerWithNames(identifiers, contexts: contexts)
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    func getContextsFromWordList(wordList: WordList) -> [Dictionary<String, String>] {
        var wordDict: [Dictionary<String, String>] = []
        for word in WordList() {
            wordDict.append([word.word: word.definition])
        }
        return wordDict
    }
    
    func getIdentifiers() -> [String] {
        var identifiers = [String]()
        for _ in 0..<10 {
            identifiers.append("PracticeIdentifier")
        }
        return identifiers
    }
    
}
