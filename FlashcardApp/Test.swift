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
        let shuffledWordList = wordList.shuffle()
        for word in shuffledWordList  {
            var possibleDefinitions = [String]()
            let wordListManager = WordListManager.sharedManager
            let numberOfWordLists = wordListManager.numberOfWordLists
            while possibleDefinitions.count < 3 {
                let randomWordList = wordListManager.wordListAtIndex(random()%numberOfWordLists)
                let randomWord = randomWordList[random()%randomWordList.count]
                if (wordList.hasWord(randomWord) == false && possibleDefinitions.contains(randomWord.definition) == false) {
                    possibleDefinitions.append(randomWord.definition)
                }
            }
            self.testQuestions.append(TestQuestion(word: word, possibleDefinitions: possibleDefinitions))
        }
    }
    
    func questionAtIndex(index: Int) -> TestQuestion {
        return testQuestions[index];
    }
    
    func indexOfQuestion(question: TestQuestion) -> Int? {
        return self.testQuestions.indexOf(question)
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


class TestQuestion: CustomStringConvertible, Equatable {
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

func ==(lhs: TestQuestion, rhs: TestQuestion) -> Bool {
    return lhs.word == rhs.word && lhs.possibleDefinitions == rhs.possibleDefinitions
}

extension CollectionType where Index == Int {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}
