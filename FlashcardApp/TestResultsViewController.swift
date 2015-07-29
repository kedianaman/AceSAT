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
    
    var test: Test?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let results = testResults()
        numberCorrectLabel.text = results.correctAnswersLabel
        numberWrongLabel.text = results.incorrectAnswersLabel
        numberUnansweredLabel.text = results.unansweredLabel
        percentageLabel.text = results.percentageLabel
        
        
    }
    
    func testResults() -> (correctAnswersLabel: String, incorrectAnswersLabel: String, unansweredLabel: String, percentageLabel: String) {
        var correctAnswers = 0
        var incorrectAnswers = 0
        var unanswered = 0
        for index in 0...test!.numberOfQuestions - 1 {
            let testQuestion = test?.questionAtIndex(index)
            if testQuestion?.userSelectedDefinition == nil {
                unanswered++
            }
            else if testQuestion?.userSelectedDefinition == testQuestion?.word.definition {
                correctAnswers++
            } else {
                incorrectAnswers++
            }
        }
        let correctAnswersLabel = "\(correctAnswers) correct"
        let incorrectAnswersLabel = "\(incorrectAnswers) incorrect"
        let unansweredLabel = "\(unanswered) unanswered"
        let percentage = Double(correctAnswers) / Double(test!.numberOfQuestions) * 100.0
        let percentageLabel = "\(Int(percentage)) %"
        return (correctAnswersLabel, incorrectAnswersLabel, unansweredLabel, percentageLabel)
        
    }
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
}

