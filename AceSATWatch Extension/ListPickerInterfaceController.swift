//
//  InterfaceController.swift
//  AceSATWatch Extension
//
//  Created by Naman Kedia on 9/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation

protocol ListPickerControllerDelegate: class {
    var currentlySelectedList: Int { get set }
}

class ListPickerInterfaceController: WKInterfaceController {
    
    var currentlySelectedIndex = 0
    
    weak var delegate: ModePickerInterfaceController?
    
    @IBOutlet var vocabularyPicker: WKInterfacePicker!
    
    @IBAction func listNumberChanged(value: Int) {
        currentlySelectedIndex = value
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let modePickerController = context as? ModePickerInterfaceController
        delegate = modePickerController
        let pickerItems = getPickerItemArray()
        vocabularyPicker.setItems(pickerItems)
    }
    
    func getPickerItemArray() -> [WKPickerItem] {
        var pickerArray = [WKPickerItem]()

        for (var i = 0; i < 100
            ; i++) {
                let pickerItem = WKPickerItem()
                pickerItem.title = "\(i+1)"
                
                pickerArray.append(pickerItem)
        }
        
        return pickerArray

    }
    
    @IBAction func doneButtonPressed() {
        delegate?.currentlySelectedList = currentlySelectedIndex
        dismissController()
    }
}
