//
//  ReviewTableViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/23/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController {

    var wordList: WordList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 96
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        tableView.backgroundColor = UIColor.blackColor()
        
        navigationController?.view.tintColor = UIColor.ace_greenColor()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationController?.barHideOnSwipeGestureRecognizer.addTarget(self, action: "hideBarOnSwipe:")
        
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hideBarOnSwipe(gesture: UIPanGestureRecognizer) {
        if gesture.state == .Ended {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            })
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        if let navigationController = navigationController {
            return navigationController.navigationBarHidden
        }
        return false
    }
    
    // MARK: - Table view data source
 
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ReviewVocabWordCell", forIndexPath: indexPath) as?ReviewTableViewCell {
            let vocabWord = wordList[indexPath.row]
            cell.wordTitle.text = vocabWord.word
            cell.wordDefinition.text = vocabWord.definition
            cell.backgroundColor = UIColor.blackColor()
            
            return cell

        }
        return UITableViewCell()
    }
  

}
