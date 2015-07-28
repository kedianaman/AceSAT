//
//  WordList.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import Foundation

class WordListManager {
    
    private var wordLists = [WordList]()
    
    // MARK:- Initialization
    
    class var sharedManager: WordListManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: WordListManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = WordListManager()
        }
        return Static.instance!
    }
    
    init() {
        let wordListPath = NSBundle.mainBundle().pathForResource("WordList", ofType: "json")!
        let wordListData = NSData(contentsOfFile: wordListPath)
        do {
            let wordListsArray = try NSJSONSerialization.JSONObjectWithData(wordListData!, options: NSJSONReadingOptions.AllowFragments) as! [[String: String]]
            
            for list in wordListsArray {
                let wordList = WordList()
                for (word, definition) in list {
                    wordList.words.append(Word(word: word, definition: definition))
                }
                wordLists.append(wordList)
            }
            print(wordLists)
        }
        catch {
            print("Error creating word list")
        }
    }
    
    // MARK:- Word List Access
    
    func numberOfWordLists() -> Int {
        return wordLists.count
    }
    
    func wordListAtIndex(index: Int) -> WordList {
        return wordLists[index];
    }
}

class WordList : CustomStringConvertible {
    private var words = [Word]()
    
    var description: String {
        var desc = ""
        for word in words {
            desc += word.description + "\n"
        }
        return desc
    }
    
    func numberOfWords() -> Int{
        return words.count
    }
    
    func wordAtIndex(index: Int) -> Word {
        return words[index]
    }

}

class Word : CustomStringConvertible {
    var word: String
    var definition: String
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
    
    var description: String {
        return word + " : " + definition
    }
}



