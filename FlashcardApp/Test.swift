//
//  Test.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import Foundation

class Test: CustomStringConvertible {
    private var testQuestions: [TestQuestion]
    
    init(wordList: WordList) {
        self.testQuestions = [TestQuestion]()
        for word in wordList {
            var possibleDefinitions = [String]()
            let wordListManager = WordListManager.sharedManager
            let numberOfWordLists = wordListManager.numberOfWordLists
            while possibleDefinitions.count < 3 {
                let randomWordList = wordListManager.wordListAtIndex(random()%numberOfWordLists)
                let randomWord = randomWordList[random()%randomWordList.count]
                if (wordList.hasWord(randomWord) == false) {
                    possibleDefinitions.append(randomWord.definition)
                }
            }
            self.testQuestions.append(TestQuestion(word: word, possibleDefinitions: possibleDefinitions))
        }
    }
    
    func questionAtIndex(index: Int) -> TestQuestion {
        return testQuestions[index];
    }
    
    var numberOfQuestions: Int {
        return testQuestions.count
    }
    
    var description: String {
        var desc = String()
        for question in testQuestions {
            desc += question.description + "\n\n"
        }
        return desc
    }
}


class TestQuestion: CustomStringConvertible {
    var word: Word
    var possibleDefinitions: [String] // 3 other definitions for multiple choice
    
    var userSelectedDefinition: String?
    
    init(word: Word, possibleDefinitions: [String]) {
        self.word = word
        self.possibleDefinitions = possibleDefinitions
    }
    
    var description: String {
        return word.description + " \n" + self.possibleDefinitions.description
    }
}