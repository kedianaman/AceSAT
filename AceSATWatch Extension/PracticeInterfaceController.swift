//
//  PracticeInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 9/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class PracticeInterfaceController: WKInterfaceController {

    @IBOutlet var wordLabel: WKInterfaceLabel!
    @IBOutlet var definitionLabel: WKInterfaceLabel!
    @IBOutlet var seeDefinitionButton: WKInterfaceButton!
    var definitionShowing = false
    
    
    @IBAction func seeDefinitionPressed() {
       
        animateWithDuration(0.2, animations: { () -> Void in
            if self.definitionShowing == false {
                self.definitionLabel.sizeToFitHeight()
                self.definitionLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Center)
                self.definitionLabel.setAlpha(1.0)
                self.seeDefinitionButton.setTitle("Hide definition")
                self.definitionShowing = true
            }
            else {
                self.definitionLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Bottom)
                self.definitionLabel.setHeight(0)
                self.definitionLabel.setAlpha(0.0)
                self.seeDefinitionButton.setTitle("See definition")
                self.definitionShowing = false

            }
        })
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let word = context as! Word
        wordLabel.setTextColor(UIColor.ace_blueColor())
        self.definitionLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Bottom)
        definitionLabel.setAlpha(0.0)
        definitionLabel.setHeight(0.0)
        
        wordLabel.setText(word.word)
        definitionLabel.setText(word.definition)
        wordLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Center)
    }
}
