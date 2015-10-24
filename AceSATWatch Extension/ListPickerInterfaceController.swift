//
//  InterfaceController.swift
//  AceSATWatch Extension
//
//  Created by Naman Kedia on 9/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity



class ListPickerInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var defualts = NSUserDefaults.standardUserDefaults()
    var session: WCSession!
    
    var currentlySelectedIndex: Int {
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
    
    
    @IBOutlet var vocabularyPicker: WKInterfacePicker!
    
    @IBAction func listNumberChanged(value: Int) {
        currentlySelectedIndex = value
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        session.sendMessage(["AcedListsRequestKey": "GetAcedLists"], replyHandler: { replyMessage in
            if let newAcedLists = replyMessage["acedLists"] as? NSMutableArray {
                self.acedLists = newAcedLists
            }
            }, errorHandler: {error in
                print(error)
        })


        let pickerItems = getPickerItemArray()
        vocabularyPicker.setItems(pickerItems)
        vocabularyPicker.setSelectedItemIndex(currentlySelectedIndex)
    }
    
    func getPickerItemArray() -> [WKPickerItem] {
        var pickerArray = [WKPickerItem]()

        for (var i = 0; i < 100
            ; i++) {
                let pickerItem = WKPickerItem()
                if acedLists.containsObject(i) {
                    pickerItem.title = "\(i+1) ★"
                }
                pickerItem.title = "\(i+1)"
                
                pickerArray.append(pickerItem)
        }
        
        return pickerArray

    }
    
    @IBAction func doneButtonPressed() {
        dismissController()
    }
}
