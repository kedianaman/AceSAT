//
//  TestResultsInterfaceController.swift
//  AceSAT
//
//  Created by Naman Kedia on 10/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import WatchKit
import Foundation


class TestResultsInterfaceController: WKInterfaceController {
    
    var test: Test?
    var wrongOrUnansweredQuestionsArray: [TestQuestion]!
    @IBOutlet var testReviewTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let newTest = context as? Test {
            test = newTest
        }
        wrongOrUnansweredQuestionsArray = collectDataFromTest()
        testReviewTable.setNumberOfRows(wrongOrUnansweredQuestionsArray!.count, withRowType: "TestResultsRowIdentifier")
        
        
        for i in 0...wrongOrUnansweredQuestionsArray!.count - 1 {
            let row = testReviewTable.rowControllerAtIndex(i) as! TestResultsTableRow
            var question = wrongOrUnansweredQuestionsArray[i]
            row.wordLabel.setTextColor(UIColor.ace_redColor())
            row.wordLabel.setText(question.word.word)
            row.correctDefinitionLabel.setText(question.word.definition)
            
            if question.userSelectedDefinition != nil {
                row.incorrectDefinitionlabel.setText(question.userSelectedDefinition)
            } else {
                row.incorrectDefinitionGroup = nil
            }
        }


        
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


}
