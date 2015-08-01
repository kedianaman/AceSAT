//
//  TestResultsViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestResultsViewController: UIViewController {

    var test: Test?
    @IBOutlet weak var testPercentageView: TestPercentageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testPercentageView.percentage = percentageOfCorrectAnswers()
        navigationController?.navigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonPressed:")
        navigationItem.rightBarButtonItem = completeButton
    }
    
    
    func endButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func percentageOfCorrectAnswers() -> Double {
        var correctAnswers = 0
        var incorrectAnswers = 0
        for index in 0...test!.numberOfQuestions - 1 {
            let testQuestion = test?.questionAtIndex(index)
            if testQuestion?.userSelectedDefinition == nil {
                incorrectAnswers++
            }
            else if testQuestion?.userSelectedDefinition == testQuestion?.word.definition {
                correctAnswers++
            } else {
                incorrectAnswers++
            }
        }
        let percentage = Double(correctAnswers) / Double(test!.numberOfQuestions) * 100.0
        return percentage
    }
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowReviewTableView" {
            if let testReviewTVC = segue.destinationViewController as? TestReviewTableViewController {
                testReviewTVC.test = self.test
            }
        }
    }
    
    

    
}

