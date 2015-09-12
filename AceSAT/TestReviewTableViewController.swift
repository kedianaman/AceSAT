//
//  TestReviewTableViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/29/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestReviewTableViewController: UITableViewController {
    
    var test: Test?
    var wrongOrUnansweredQuestions: [TestQuestion]?
    var correctAnswers: Int? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongOrUnansweredQuestions = collectDataFromTest()
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        tableView.backgroundColor = UIColor.blackColor()
        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.translucent = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonPressed:")
        navigationItem.rightBarButtonItem = completeButton

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func endButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    func collectDataFromTest() -> [TestQuestion]? {
        if let test = test {
            var wrongOrUnansweredQuestionsArray = [TestQuestion]()
            for index in 0...test.numberOfQuestions - 1 {
                let testQuestion = test.questionAtIndex(index)
                if testQuestion.userSelectedDefinition == nil {
                    wrongOrUnansweredQuestionsArray.append(testQuestion)
                } else if testQuestion.userSelectedDefinition != testQuestion.word.definition {
                    wrongOrUnansweredQuestionsArray.append(testQuestion)
                }
                
            }
            return wrongOrUnansweredQuestionsArray
        }
        return nil
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wrongOrUnansweredQuestions!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TestReviewTableViewCell", forIndexPath: indexPath) as! TestReviewTableViewCell
        let testQuestion = wrongOrUnansweredQuestions![indexPath.row]
        cell.wordLabel.text = testQuestion.word.word
        cell.correctDefinitionLabel.text = testQuestion.word.definition
        if testQuestion.userSelectedDefinition != nil {
            cell.setUserSelectedDefinitionText(testQuestion.userSelectedDefinition!)
        } else {
            cell.setUserSelectedDefinitionText(nil)
        }
        cell.backgroundColor = UIColor.blackColor()

        return cell
    }
}
