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
    
    var currentlySelectedList: Int {
        set {
            NSUserDefaults(suiteName: "group.namankedia.AceSATApp")?.setValue(newValue, forKey: "SelectedWordListKey")
        }
        get {
            if let index = NSUserDefaults(suiteName: "group.namankedia.AceSATApp")?.valueForKey("SelectedWordListKey") as? Int {
                return index
            } else {
                return 0
                
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        self.setTitle("AceSAT: \(currentlySelectedList + 1)")
    }
    @IBAction func chooseListButtonPressed() {
        presentControllerWithName("ListPicker", context: nil)
    }

    @IBAction func reviewButtonPressed() {
        let contexts = WordListManager.sharedManager.wordListAtIndex(currentlySelectedList).allWords
        presentControllerWithName(ControllerIdentifier.ReviewIdentifier, context: contexts)
    }
    
    
    @IBAction func practiceButtonPressed() {
        let contexts = WordListManager.sharedManager.wordListAtIndex(currentlySelectedList).allWords
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.PracticeIdentifier)
        }
        
        presentControllerWithNames(identifiers, contexts: contexts)
    }
    
    @IBAction func testButtonPressed() {
        let wordList = WordListManager.sharedManager.wordListAtIndex(currentlySelectedList)
        let contexts = Test(wordList: wordList).allQuestions
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.TestIdentifier)
        }
        
        presentControllerWithNames(identifiers, contexts: contexts)

        
    }
}
