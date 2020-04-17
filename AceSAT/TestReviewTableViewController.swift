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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        tableView.backgroundColor = UIColor.black
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TestReviewTableViewController.endButtonPressed(_:)))
        navigationItem.rightBarButtonItem = completeButton

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc func endButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wrongOrUnansweredQuestions!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestReviewTableViewCell", for: indexPath) as! TestReviewTableViewCell
        let testQuestion = wrongOrUnansweredQuestions![indexPath.row]
        cell.wordLabel.text = testQuestion.word.word
        cell.correctDefinitionLabel.text = testQuestion.word.definition
        if testQuestion.userSelectedDefinition != nil {
            cell.setUserSelectedDefinitionText(testQuestion.userSelectedDefinition!)
        } else {
            cell.setUserSelectedDefinitionText(nil)
        }
        cell.backgroundColor = UIColor.black

        return cell
    }
}
