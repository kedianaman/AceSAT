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
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var listPicker: WKInterfacePicker!
    
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
    
    var acedLists: NSMutableArray {
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "AcedWordListsKey")
        }
        get {
            if let acedLists = NSUserDefaults.standardUserDefaults().valueForKey("AcedWordListsKey") as? NSMutableArray {
                return acedLists
            } else {
                return NSMutableArray()
                
            }
            
        }
    }

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        updateTitleFont()
        let pickerItems = getPickerItemsArray()
        listPicker.setItems(pickerItems)
        listPicker.setSelectedItemIndex(currentlySelectedList)
        
    }

    override func willActivate() {
        super.willActivate()
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        if let acedLists = applicationContext["AcedLists"] as? NSMutableArray {
            NSUserDefaults.standardUserDefaults().setValue(acedLists, forKey: "AcedWordListsKey")
        }
    }
    
    //* Setup methods
 
    private func getPickerItemsArray() -> [WKPickerItem] {
        var pickerArray = [WKPickerItem]()
        
        for (var i = 0; i < 100
            ; i++) {
                let pickerItem = WKPickerItem()
                if acedLists.containsObject(i) {
                    pickerItem.title = "\(i+1) ★"
                } else {
                    pickerItem.title = "\(i+1)"
                }
                
                pickerArray.append(pickerItem)
        }
        
        return pickerArray
        

    }
    private func updateTitleFont() {
        let thinFont = UIFont.systemFontOfSize(40, weight: UIFontWeightUltraLight)
        let lightFont = UIFont.systemFontOfSize(40, weight: UIFontWeightLight)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.whiteColor()])
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "CE", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(32, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName : UIColor.whiteColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "S", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_greenColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_blueColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "T", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_redColor()]))
        
        titleLabel.setAttributedText(mainTitle)
        
        
    }


  
    @IBAction func listSelected(value: Int) {
        currentlySelectedList = value
    }
    
    
    @IBAction func practiceButtonPressed() {
        let contexts = WordListManager.sharedManager.wordListAtIndex(currentlySelectedList).allWords
        
        var identifiers = [String]()
        for _ in 0..<contexts.count {
            identifiers.append(ControllerIdentifier.PracticeIdentifier)
        }
        
        presentControllerWithNames(identifiers, contexts: contexts)
    }
    
   }
