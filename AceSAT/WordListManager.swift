//
//  WordList.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import Foundation
import WatchConnectivity

class WordListManager: NSObject {
    
    fileprivate var wordLists = [WordList]()
    
    var allWords = [Word]()
    
    var session: WCSession!
    
    // MARK:- Initialization
    
    class var sharedManager: WordListManager {
        struct Static {
            static let instance = WordListManager()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        let wordListPath = Bundle.main.path(forResource: "WordList", ofType: "json")!
        let wordListData = try? Data(contentsOf: URL(fileURLWithPath: wordListPath))
        do {
            let wordListsArray = try JSONSerialization.jsonObject(with: wordListData!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String: String]]
            
            for list in wordListsArray {
                let wordList = WordList()
                for (word, definition) in list {
                    allWords.append(Word(word: word, definition: definition))
                    wordList.words.append(Word(word: word, definition: definition))
                }
                wordLists.append(wordList)
            }
        }
        catch {
            print("Error creating word list")
        }
        
        if WCSession.isSupported() {
            session = WCSession.default()
            session.activate()
        }
    }
    
    // MARK:- Storing NSUseDefaults
    
    struct DefaultsKey {
        static let AcedWordListKey = "AcedWordLists"
    }
    
    func setAced(_ wordList: WordList) {
        let defaults = UserDefaults.standard
        let acedWordLists: NSMutableArray
        if let lists = defaults.object(forKey: DefaultsKey.AcedWordListKey) {
            acedWordLists = (lists as AnyObject).mutableCopy() as! NSMutableArray
        }
        else {
            acedWordLists = NSMutableArray()
        }
        
        let index = wordLists.index(of: wordList)!
        if acedWordLists.contains(index) == false {
            acedWordLists.add(index)
        }
        
        defaults.set(acedWordLists, forKey: DefaultsKey.AcedWordListKey)
    }
    
    func getAced(_ wordList: WordList) -> Bool {
        let index = wordLists.index(of: wordList)!
        if let acedWordLists = UserDefaults.standard.object(forKey: DefaultsKey.AcedWordListKey) {
            return (acedWordLists as AnyObject).contains(index)
        }
        return false
    }
    
    func updateApplicationContext() {
        if session != nil {
            var acedLists =  NSMutableArray()
            if let acedWordLists = UserDefaults.standard.object(forKey: DefaultsKey.AcedWordListKey) as? NSMutableArray {
                acedLists = acedWordLists
            }
            do {
                let applicationDict = ["AcedLists": acedLists]
                try session.updateApplicationContext(applicationDict)
            } catch {
                print("error")
            }
        }
    }
    
    func getAcedLists() -> NSMutableArray {
        if let acedWordLists = UserDefaults.standard.object(forKey: DefaultsKey.AcedWordListKey) as? NSMutableArray {
            return acedWordLists
        }
        return NSMutableArray()
    }
    
    // MARK:- Word List Access
    
    var numberOfWordLists: Int {
        return wordLists.count
    }
    
    func wordListAtIndex(_ index: Int) -> WordList {
        return wordLists[index];
    }
    
}


class WordList : CustomStringConvertible, Collection, Equatable {
    
    typealias Iterator = IndexingIterator<[Word]>
    typealias _Element = Word

    fileprivate var words = [Word]()
    
    typealias Element = Word
    
    func randomize() {
        words = self.words.shuffle()
    }
    
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
    
    func index(after i: Int) -> Int {
        return i + 1
    }

    func makeIterator() -> Iterator {
        return words.makeIterator()
    }
    
    subscript(i: Int) -> Word {
        return words[i]
    }
    
    func hasWord(_ word: Word) -> Bool {
        return contains { (aWord) -> Bool in
            return word == aWord
        }
    }
    
    var allWords: [Word] {
        return words
    }
}

func ==(lhs: WordList, rhs: WordList) -> Bool {
    return lhs.words == rhs.words
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
