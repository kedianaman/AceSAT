//
//  ModePickerInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/3/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

struct ControllerIdentifier {
    static let ReviewIdentifier = "ReviewIdentifier"
    static let PracticeIdentifier = "PracticeIdentifier"
    static let TestIdentifier = "TestIdentifier"
}

class ModePickerInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session: WCSession!
    
    var currentlySelectedList: Int {
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "SelectedWordListKey")
        }
        get {
            if let index = NSUserDefaults.standardUserDefaults().valueForKey("SelectedWordListKey") as? Int {
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
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        self.setTitle("AceSAT: \(currentlySelectedList + 1)")
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        if let acedLists = applicationContext["AcedLists"] as? NSMutableArray {
            NSUserDefaults.standardUserDefaults().setValue(acedLists, forKey: "AcedWordListsKey")
        }
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
        let test = Test(wordList: wordList)
        var contexts:[AnyObject] = test.allQuestions
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.TestIdentifier)
        }
        identifiers.append("DoneController")
        contexts.append(test)
        
        presentControllerWithNames(identifiers, contexts: contexts)

        
    }
}
