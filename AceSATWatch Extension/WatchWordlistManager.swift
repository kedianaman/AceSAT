//
//  WatchWordlistManager.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/29/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import Foundation

import Foundation
import WatchConnectivity

class WatchWordlistManager: NSObject, WCSessionDelegate {
    
    var session: WCSession!
    
    // MARK:- Initialization
    
    class var sharedManager: WatchWordlistManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: WatchWordlistManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = WatchWordlistManager()
        }
        return Static.instance!
    }
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }

    }
    
    // MARK:- Storing NSUseDefaults
    
    struct DefaultsKey {
        static let AcedWordListKey = "AcedWordListsKey"
    }
    
//    func setAced(wordList: WordList) {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let acedWordLists: NSMutableArray
//        if let lists = defaults.objectForKey(DefaultsKey.AcedWordListKey) {
//            acedWordLists = lists.mutableCopy() as! NSMutableArray
//        }
//        else {
//            acedWordLists = NSMutableArray()
//        }
//        
//        let index = wordLists.indexOf(wordList)!
//        if acedWordLists.containsObject(index) == false {
//            acedWordLists.addObject(index)
//        }
//        
//        defaults.setObject(acedWordLists, forKey: DefaultsKey.AcedWordListKey)
//    }
//    
//    func getAced(wordList: WordList) -> Bool {
//        let index = wordLists.indexOf(wordList)!
//        if let acedWordLists = NSUserDefaults.standardUserDefaults().objectForKey(DefaultsKey.AcedWordListKey) {
//            return acedWordLists.containsObject(index)
//        }
//        return false
//    }
    
    func updateApplicationContext() {
        var acedLists =  NSMutableArray()
        if let acedWordLists = NSUserDefaults.standardUserDefaults().objectForKey(DefaultsKey.AcedWordListKey) as? NSMutableArray {
            acedLists = acedWordLists
        }
        do {
            let applicationDict = ["AcedLists": acedLists]
            try session.updateApplicationContext(applicationDict)
        } catch {
            print("error")
        }
    }

    
    
    
    
    
}
