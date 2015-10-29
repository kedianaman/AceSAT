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
    var wordList: WordList?
    var wrongOrUnansweredQuestionsArray: [TestQuestion]!
    @IBOutlet var testReviewTable: WKInterfaceTable!
    @IBOutlet var ringImage: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let newWordList = context as? WordList {
            wordList = newWordList
            test = Test(wordList: wordList!)
        }
        setUpTable()
        startAnimatingImage()
    }
    
    func setUpTable() {
         wrongOrUnansweredQuestionsArray = collectDataFromTest()
        testReviewTable.setNumberOfRows(wrongOrUnansweredQuestionsArray!.count, withRowType: "TestResultsRowIdentifier")
        if wrongOrUnansweredQuestionsArray.count > 0 {
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
        
    
        

        
    }
    
    func startAnimatingImage() {
        let correctAnswers = calculateCorrectAnswers()
        ringImage.setImageNamed("ring")
        ringImage.startAnimatingWithImagesInRange(NSMakeRange(0, correctAnswers+1), duration: 0.4, repeatCount: 1)

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
