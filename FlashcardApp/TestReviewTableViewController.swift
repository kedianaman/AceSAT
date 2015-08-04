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
        // #warning Incomplete implementation, return the number of rows
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

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
