//
//  TestResultsViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestResultsViewController: UIViewController {

    @IBOutlet weak var numberCorrectLabel: UILabel!
    @IBOutlet weak var numberWrongLabel: UILabel!
    @IBOutlet weak var numberUnansweredLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var correctText: String!
    var wrongText: String!
    var unansweredText: String!
    var percentageText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberCorrectLabel.text = correctText
        numberWrongLabel.text = wrongText
        numberUnansweredLabel.text = unansweredText
        percentageLabel.text = percentageText
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReviewUnwindSegue" {
            if let tpvc = segue.destinationViewController as? TestPageViewController {
                for index in 0..<tpvc.test.numberOfQuestions {
                    let testViewController = tpvc.testViewControllerAtIndex(index) as TestViewController
                    if testViewController.testQuestion?.userSelectedDefinition == nil || testViewController.testQuestion?.word.definition != testViewController.testQuestion?.userSelectedDefinition {
                        // make correct word def green
                        print("wrong or unanswered")
                    } else {
                        print("correct")
                        // do nothing at the moment.
                    }
                }
            }
        }
    }
}

