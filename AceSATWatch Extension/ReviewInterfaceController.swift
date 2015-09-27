//
//  ReviewInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 9/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class ReviewInterfaceController: WKInterfaceController {

    @IBOutlet var reviewTable: WKInterfaceTable!
    
    let temporaryWordsDict = ["Abhor":"hate",
        "Bigot":"narrow-minded, prejudiced person",
        "Counterfeit":"fake; false",
        "Enfranchise":"give voting rights",
        "Hamper":"hinder; obstruct",
        "Kindle":"to start a fire",
        "Noxious":"harmful; poisonous; lethal",
        "Placid":"calm; peaceful",
        "Remuneration":"payment for work done",
        "Talisman":"lucky charm"]

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        reviewTable.setNumberOfRows(temporaryWordsDict.count, withRowType: "ReviewWordsRowIdentifier")
        
        var i = 0
        for (word, definition) in temporaryWordsDict {
            let row = reviewTable.rowControllerAtIndex(i) as! ReviewTableRow
            row.titleLabel.setText(word)
            row.titleLabel.setTextColor(UIColor.ace_greenColor())
            row.definitionLabel.setText(definition)
            i++
        }
        
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
