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
    static let PracticeIdentifier = "PracticeIdentifier"
}

class ModePickerInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session: WCSession!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var listPicker: WKInterfacePicker!
    @IBOutlet var practiceButton: WKInterfaceButton!
    
    var currentlySelectedList: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "SelectedWordListKey")
        }
        get {
            if let index = UserDefaults.standard.value(forKey: "SelectedWordListKey") as? Int {
                return index
            } else {
                return 0
                
            }
        }
    }
    
    var acedLists: NSMutableArray {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "AcedWordListsKey")
        }
        get {
            if let acedLists = UserDefaults.standard.value(forKey: "AcedWordListsKey") as? NSMutableArray {
                return acedLists
            } else {
                return NSMutableArray()
                
            }
            
        }
    }

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateTitleFont()
        let pickerItems = getPickerItemsArray()
        listPicker.setItems(pickerItems)
        listPicker.setSelectedItemIndex(currentlySelectedList)
    }

    override func willActivate() {
        super.willActivate()
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let acedLists = applicationContext["AcedLists"] as? NSMutableArray {
            UserDefaults.standard.setValue(acedLists, forKey: "AcedWordListsKey")
        }
    }
    
    @available(watchOS 2.2, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    //* Setup methods
 
    fileprivate func getPickerItemsArray() -> [WKPickerItem] {
        var pickerArray = [WKPickerItem]()
        
        for i in 0 ..< 100 {
                let pickerItem = WKPickerItem()
                if acedLists.contains(i) {
                    pickerItem.title = "\(i+1) ★"
                } else {
                    pickerItem.title = "\(i+1)"
                }
                
                pickerArray.append(pickerItem)
        }
        
        return pickerArray
        

    }
    fileprivate func updateTitleFont() {
        let thinFont = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.light)
        let lightFont = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.regular)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSAttributedString.Key.font : thinFont, NSAttributedString.Key.foregroundColor : UIColor.white])
        mainTitle.append(NSMutableAttributedString(string: "CE", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.light), NSAttributedString.Key.foregroundColor : UIColor.white]))
        mainTitle.append(NSMutableAttributedString(string: "S", attributes: [NSAttributedString.Key.font : lightFont, NSAttributedString.Key.foregroundColor : UIColor.ace_greenColor()]))
        mainTitle.append(NSMutableAttributedString(string: "A", attributes: [NSAttributedString.Key.font : lightFont, NSAttributedString.Key.foregroundColor : UIColor.ace_blueColor()]))
        mainTitle.append(NSMutableAttributedString(string: "T", attributes: [NSAttributedString.Key.font : lightFont, NSAttributedString.Key.foregroundColor : UIColor.ace_redColor()]))
        
        titleLabel.setAttributedText(mainTitle)
        
        
    }


  
    @IBAction func listSelected(_ value: Int) {
        currentlySelectedList = value
    }
    
    
    @IBAction func practiceButtonPressed() {
        let contexts = WordListManager.sharedManager.wordListAtIndex(currentlySelectedList).allWords
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.PracticeIdentifier)
        }
        
        presentController(withNames: identifiers, contexts: contexts)
    }
    
   }
