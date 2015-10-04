//
//  ModePickerInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/3/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation

struct ControllerIdentifier {
    static let ReviewIdentifier = "ReviewIdentifier"
    static let PracticeIdentifier = "PracticeIdentifier"
    static let TestIdentifier = "TestIdentifier"
}

class ModePickerInterfaceController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    @IBAction func chooseListButtonPressed() {
        presentControllerWithName("ListPicker", context: nil)
    }

    @IBAction func practiceButtonPressed() {
        let contexts = WordListManager.sharedManager.wordListAtIndex(0).allWords
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.PracticeIdentifier)
        }
        
        presentControllerWithNames(identifiers, contexts: contexts)
    }
    
    @IBAction func testButtonPressed() {
        let wordList = WordListManager.sharedManager.wordListAtIndex(0)
        let contexts = Test(wordList: wordList).allQuestions
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.TestIdentifier)
        }
        
        presentControllerWithNames(identifiers, contexts: contexts)

        
    }
}
