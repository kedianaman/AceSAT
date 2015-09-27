//
//  InterfaceController.swift
//  AceSATWatch Extension
//
//  Created by Naman Kedia on 9/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var vocabularyPicker: WKInterfacePicker!
    var pickerArray = [WKPickerItem]()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        for (var i = 0; i < 10
            ; i++) {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\(i)"
            pickerArray.append(pickerItem)
        }
        
        vocabularyPicker.setItems(pickerArray)    
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
