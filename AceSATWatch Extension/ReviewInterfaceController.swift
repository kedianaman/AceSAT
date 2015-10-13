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
    
//    let wordList = WordListManager.sharedManager.wordListAtIndex(1)
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let index = 1
        let words = context as! [Word]
        let wordList = WordListManager.sharedManager.wordListAtIndex(index)
        reviewTable.setNumberOfRows(words.count, withRowType: "ReviewWordsRowIdentifier")
        


        
        var i = 0
        for word in words {
            let row = reviewTable.rowControllerAtIndex(i) as! ReviewTableRow
            row.titleLabel.setText(word.word)
            row.titleLabel.setTextColor(UIColor.ace_greenColor())
            row.definitionLabel.setText(word.definition)
            i++
        }
        
        // Configure interface objects here.
    }


}
