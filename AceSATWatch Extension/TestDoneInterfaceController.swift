//
//  TestDoneInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class TestDoneInterfaceController: WKInterfaceController {

    var test: Test?
    var wordList: WordList?
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        wordList = context as? WordList
        test = Test(wordList: wordList!)
    }

    @IBAction func testButtonPressed() {
        presentControllerWithName("TestResultsControllerIdentifier", context: wordList)
    }
}
