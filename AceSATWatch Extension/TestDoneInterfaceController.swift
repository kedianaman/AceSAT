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
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        test = context as? Test
    }

    @IBAction func testButtonPressed() {
        presentControllerWithName("TestResultsControllerIdentifier", context: test)
    }
}
