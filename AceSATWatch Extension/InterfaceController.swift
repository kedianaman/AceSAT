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

    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        for (var i = 0; i < 100
            ; i++) {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\(i+1)"

            pickerArray.append(pickerItem)
        }
        
        setTitleText()
        vocabularyPicker.setItems(pickerArray)
        
    }

    
    func setTitleText() {
        
        let thinFont = UIFont.systemFontOfSize(40.0, weight: UIFontWeightUltraLight)
        let lightFont = UIFont.systemFontOfSize(40.0, weight: UIFontWeightLight)

        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.whiteColor()])
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "CE", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(32.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName : UIColor.whiteColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "S", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_greenColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_blueColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "T", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_redColor()]))
        
        titleLabel.setAttributedText(mainTitle)
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
