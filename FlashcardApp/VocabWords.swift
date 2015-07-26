//
//  VocabWords.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/23/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import Foundation

class VocabWords {

    
    let path = NSBundle.mainBundle().pathForResource("Wordlist", ofType: "json")!
    var wordList: [[String: String]]?
    
    func getWordsAtIndex(index: Int) -> Dictionary<String, String>? {
        let jsonData = NSData(contentsOfFile: path)
        do {
            wordList = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments) as! [[String: String]]
            return wordList![index]
            
        } catch {
            print("couldn't get wordlist")
        }
        return nil

    }
}
