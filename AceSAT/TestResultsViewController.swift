//
//  TestResultsViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit
import WatchConnectivity

class TestResultsViewController: UIViewController, WCSessionDelegate {

    var test: Test?
    var wordList: WordList?
    var session: WCSession!
    
    @IBOutlet weak var testPercentageView: TestPercentageView!
    @IBOutlet weak var testResultsContainerTableView: UIView!
    @IBOutlet weak var resultsStackview: UIStackView!
    @IBOutlet weak var acedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWCSession()
        let correctAnswers = calculateCorrectAnswers()
        testPercentageView.numberOfQuestions = test?.numberOfQuestions
        testPercentageView.correctAnswers = correctAnswers
        if correctAnswers == test?.numberOfQuestions {
            testResultsContainerTableView.removeFromSuperview()
            resultsStackview.addArrangedSubview(acedLabel)
            acedLabel.alpha = 1
            WordListManager.sharedManager.setAced(wordList!)
        }
        navigationController?.navigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonPressed:")
        navigationItem.rightBarButtonItem = completeButton
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateAxisForTraitCollection(traitCollection)
        testPercentageView.animate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateAxisForBoundsChange(view.bounds.size)
    }

    
    func endButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setUpWCSession() {
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }

    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        if let messageRequest = message["AcedListsRequestKey"] as? String {
            if messageRequest == "GetAcedLists" {
                let acedLists = WordListManager.sharedManager.getAcedLists()
                acedLists
                replyHandler(["acedLists": acedLists])
            }
        }
    }
    
    // MARK:- Trait Collection Changes
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        updateAxisForTraitCollection(newCollection)
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAxisForTraitCollection(self.view.traitCollection)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        updateAxisForBoundsChange(size)
    }


// MARK - Stack view orientation 
    func updateAxisForTraitCollection(traitCollection: UITraitCollection) {
        if traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact {
            resultsStackview.axis = UILayoutConstraintAxis.Horizontal
        }
        else if traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular {
            updateAxisForBoundsChange(view.bounds.size)
        }
        else {
             resultsStackview.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    func updateAxisForBoundsChange(size: CGSize) {
        if traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular {
            // iPad - check orientation in this case.
            if size.width > size.height {
                 resultsStackview.axis = UILayoutConstraintAxis.Horizontal
            }
            else {
                 resultsStackview.axis = UILayoutConstraintAxis.Vertical
            }
        }
    }

    
    func calculateCorrectAnswers() -> Int {
        var correctAnswers = 0
        for index in 0...test!.numberOfQuestions - 1 {
            let testQuestion = test?.questionAtIndex(index)
            if testQuestion?.userSelectedDefinition == testQuestion?.word.definition {
                correctAnswers++
            }
        }
        return correctAnswers
    }
    
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowReviewTableView" {
            if let testReviewTVC = segue.destinationViewController as? TestReviewTableViewController {
                testReviewTVC.test = self.test
                testReviewTVC.correctAnswers = calculateCorrectAnswers()
            }
        }
    }
    
    

    
}

