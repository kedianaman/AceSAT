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
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vocabWords.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vocabWordCell", forIndexPath: indexPath) as UITableViewCell
        let vocabWord = vocabWords.keys.array[indexPath.row]
        cell.textLabel?.text = vocabWord
        cell.detailTextLabel?.text = vocabWords[vocabWord]

        return cell
    }
  

}
