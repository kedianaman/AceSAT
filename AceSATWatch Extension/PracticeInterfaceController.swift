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
    var definitionShowing = false
    
    
    @IBAction func seeDefinitionPressed() {
       
        animate(withDuration: 0.2, animations: { () -> Void in
            if self.definitionShowing == false {
                self.definitionLabel.sizeToFitHeight()
                self.definitionLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.center)
                self.definitionLabel.setAlpha(1.0)
                self.definitionShowing = true
            }
            else {
                self.definitionLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.bottom)
                self.definitionLabel.setAlpha(0.0)
                self.definitionLabel.setHeight(0)
                self.definitionShowing = false
            }
        })
    }
    

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let word = context as! Word
        
        wordLabel.setTextColor(UIColor.ace_blueColor())
        wordLabel.setText(word.word)
        wordLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.center)
        wordLabel.setAlpha(1)

        definitionLabel.setText(word.definition)
        definitionLabel.setHeight(0)
        definitionLabel.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.bottom)
        definitionLabel.setAlpha(1)

        self.setTitle("Done")
    }
}
