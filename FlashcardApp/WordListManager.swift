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
        let wordListPath = NSBundle.mainBundle().pathForResource("MyWordList", ofType: "json")!
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
    
    var numberOfWordLists: Int {
        return wordLists.count
    }
    
    func wordListAtIndex(index: Int) -> WordList {
        return wordLists[index];
    }
}

class WordList : CustomStringConvertible, CollectionType {
    typealias Generator = IndexingGenerator<[Word]>
    typealias _Element = Word

    
    private var words = [Word]()
    
    typealias Element = Word
    
    var description: String {
        var desc = ""
        for word in words {
            desc += word.description + "\n"
        }
        return desc
    }
    
    var startIndex: Int {
        return words.startIndex
    }
    
    var endIndex: Int {
        return words.endIndex
    }
    
    func generate() -> Generator {
        return words.generate()
    }
    
    subscript(i: Int) -> Word {
        return words[i]
    }
    
    func hasWord(word: Word) -> Bool {
        return contains({ (aWord) -> Bool in
            return word == aWord
        })
    }
}


class Word : CustomStringConvertible, Equatable {
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

func ==(lhs: Word, rhs: Word) -> Bool {
    return lhs.word == rhs.word && lhs.definition == rhs.definition
}
