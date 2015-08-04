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
    @IBOutlet weak var testResultsContainerTableView: UIView!
    @IBOutlet weak var resultsStackview: UIStackView!
    @IBOutlet weak var acedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let correctAnswers = calculateCorrectAnswers()
        testPercentageView.numberOfQuestions = test?.numberOfQuestions
        testPercentageView.correctAnswers = correctAnswers
        if correctAnswers == test?.numberOfQuestions {
            testResultsContainerTableView.removeFromSuperview()
            resultsStackview.addArrangedSubview(acedView)
            acedView.hidden = false
        }
        navigationController?.navigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonPressed:")
        navigationItem.rightBarButtonItem = completeButton
    }
    
    override func viewDidAppear(animated: Bool) {
        testPercentageView.animate()
    }
    
    func endButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func calculateCorrectAnswers() -> Int {
        var correctAnswers = 0
        for index in 0...test!.numberOfQuestions - 1 {
            let testQuestion = test?.questionAtIndex(index)
            if testQuestion?.userSelectedDefinition == testQuestion?.word.definition {
                correctAnswers++
            }
        }
        return correctAnswers
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

