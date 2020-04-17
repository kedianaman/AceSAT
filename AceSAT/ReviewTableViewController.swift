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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        tableView.backgroundColor = UIColor.black
        
        navigationController?.view.tintColor = UIColor.ace_greenColor()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationController?.barHideOnSwipeGestureRecognizer.addTarget(self, action: #selector(ReviewTableViewController.hideBarOnSwipe(_:)))
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideBarOnSwipe(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            })
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        if let navigationController = navigationController {
            return navigationController.isNavigationBarHidden || super.prefersStatusBarHidden
        }
        return super.prefersStatusBarHidden
    }
    
    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewVocabWordCell", for: indexPath) as?ReviewTableViewCell {
            let vocabWord = wordList[indexPath.row]
            cell.wordTitle.text = vocabWord.word
            cell.wordDefinition.text = vocabWord.definition
            cell.backgroundColor = UIColor.black
            
            return cell

        }
        return UITableViewCell()
    }
  

}
