//
//  ReviewTableViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/23/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController {

    let vocabWords = VocabWords().getWordsAtIndex(5)!
    
   
    // MARK: - Table view data source

 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 96
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        navigationController?.view.window?.tintColor = UIColor(red:0.51, green:0.98, blue:0.43, alpha:1.0)
        
        navigationController?.hidesBarsOnSwipe = true
        tableView.backgroundColor = UIColor.blackColor()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabWords.count
    }
    


   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ReviewVocabWordCell", forIndexPath: indexPath) as?ReviewTableViewCell {
            let vocabWord = vocabWords.keys.array[indexPath.row]
            cell.wordTitle.text = vocabWord
            cell.wordDefinition.text = vocabWords[vocabWord]
            
            return cell

        }
        return UITableViewCell()
    }
  

}
