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
    

    @IBOutlet var definitionLabel1: WKInterfaceButton!
    @IBOutlet var definitionLabel2: WKInterfaceButton!
    @IBOutlet var definitionLabel3: WKInterfaceButton!
    @IBOutlet var definitionLabel4: WKInterfaceButton!
    
    var buttons = [WKInterfaceButton]()
    
    var testQuestion: TestQuestion?
    
    @IBOutlet var wordLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        testQuestion = context as? TestQuestion        
        wordLabel.setTextColor(UIColor.ace_redColor())
        wordLabel.setText(testQuestion?.word.word)
        
        buttons = [definitionLabel1, definitionLabel2, definitionLabel3, definitionLabel4]
        var definitions = testQuestion!.possibleDefinitions
        definitions.insert(testQuestion!.word.definition, atIndex: random() % 4)
        for i in 0..<definitions.count {
            buttons[i].setTitle(definitions[i])
        }
    }

    @IBAction func definitionTapped(sender: WKInterfaceButton) {
        sender.setBackgroundColor(UIColor.ace_redColor())
        
    }

}
