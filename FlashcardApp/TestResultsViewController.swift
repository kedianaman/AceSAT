//
//  TestResultsViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestResultsViewController: UIViewController {

    @IBOutlet weak var numberCorrectLabel: UILabel!
    @IBOutlet weak var numberWrongLabel: UILabel!
    @IBOutlet weak var numberUnansweredLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var correctText: String!
    var wrongText: String!
    var unansweredText: String!
    var percentageText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberCorrectLabel.text = correctText
        numberWrongLabel.text = wrongText
        numberUnansweredLabel.text = unansweredText
        percentageLabel.text = percentageText
    }
}
