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
        numberCorrectLabel.text = "\(results.correctAnswers) correct"
        numberWrongLabel.text = "\(results.incorrectAnswers) incorrect"
        numberUnansweredLabel.text = "\(results.unanswered) unanswered"
        let percentage = Double(results.correctAnswers) / Double(test!.numberOfQuestions) * 100.0
        percentageLabel.text = "\(Int(percentage)) %"
        
        
    }
    
    func testResults() -> (correctAnswers: Int, incorrectAnswers: Int, unanswered: Int) {
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
        return (correctAnswers, incorrectAnswers, unanswered)
        
    }
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
}

