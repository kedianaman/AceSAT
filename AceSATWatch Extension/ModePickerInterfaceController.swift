//
//  ModePickerInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/3/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class ModePickerInterfaceController: WKInterfaceController {
    
    var wordList: WordList?

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
    
    @IBAction func chooseListButtonPressed() {
        presentControllerWithName("ListPicker", context: nil)
    }


    @IBAction func practiceButtonPressed() {
        print("practice button pressed")

        let contexts = getContextsFromWordList(wordList!)
        let identifiers = getIdentifiers()
        presentControllerWithNames(identifiers, contexts: contexts)

    }
    @IBAction func testButtonPressed() {
        print("test button pressed")
    }
   
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let index = ListPickerInterfaceController.sharedManager.currentlySelectedIndex
        wordList = WordListManager.sharedManager.wordListAtIndex(index)
    }
}
