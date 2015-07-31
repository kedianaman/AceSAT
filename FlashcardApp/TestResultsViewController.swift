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
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    var test: Test?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let results = testResults()
        reviewButton.setTitleColor(UIColor.ace_redColor(), forState: UIControlState.Normal)
        numberCorrectLabel.text = results.correctAnswersLabel
        numberWrongLabel.text = results.incorrectAnswersLabel
        percentageLabel.text = results.percentageLabel
        navigationController?.navigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonPressed:")
        navigationItem.rightBarButtonItem = completeButton
    }
    
    
    func endButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func testResults() -> (correctAnswersLabel: String, incorrectAnswersLabel: String, percentageLabel: String) {
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
        let correctAnswersLabel = "\(correctAnswers) correct"
        let incorrectAnswersLabel = "\(incorrectAnswers) incorrect"
        let percentage = Double(correctAnswers) / Double(test!.numberOfQuestions) * 100.0
        let percentageLabel = "\(Int(percentage)) %"
        if incorrectAnswers == 0 {
            reviewButton.setTitle("Great Job!", forState: UIControlState.Normal)
            reviewButton.enabled = false 
        }
        return (correctAnswersLabel, incorrectAnswersLabel, percentageLabel)
        
    }
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReviewSegueToTableView" {
            if let testReviewTVC = segue.destinationViewController as? TestReviewTableViewController {
                testReviewTVC.test = self.test
            }
        }
    }
    
    

    
}

