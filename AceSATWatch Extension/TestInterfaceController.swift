//
//  TestInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/4/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class TestInterfaceController: WKInterfaceController {
    
    @IBOutlet var definitionsPicker: WKInterfacePicker!
    var testQuestion: TestQuestion?
    @IBOutlet var wordLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        testQuestion = context as! TestQuestion
        let items = getPickerItemArray()
        definitionsPicker.setItems(items)
        wordLabel.setTextColor(UIColor.ace_redColor())
        wordLabel.setText(testQuestion?.word.word)
        
        // Configure interface objects here.
    }

    func getPickerItemArray() -> [WKPickerItem] {
        var pickerArray = [WKPickerItem]()
        for definition in testQuestion!.possibleDefinitions {
            let item = WKPickerItem()
            item.title = definition
            pickerArray.append(item)
        }
        let randomIndex = random()%4
        let item = WKPickerItem()
        item.title = testQuestion?.word.definition
        pickerArray.insert(item, atIndex: randomIndex)
        return pickerArray
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
