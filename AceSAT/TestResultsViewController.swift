//
//  TestResultsViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/28/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestResultsViewController: UIViewController {

    var test: Test?
    var wordList: WordList?
    
    @IBOutlet weak var testPercentageView: TestPercentageView!
    @IBOutlet weak var testResultsContainerTableView: UIView!
    @IBOutlet weak var resultsStackview: UIStackView!
    @IBOutlet weak var acedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let correctAnswers = calculateCorrectAnswers()
        testPercentageView.numberOfQuestions = test?.numberOfQuestions
        testPercentageView.correctAnswers = correctAnswers
        if correctAnswers == test?.numberOfQuestions {
            testResultsContainerTableView.removeFromSuperview()
            resultsStackview.addArrangedSubview(acedLabel)
            acedLabel.alpha = 1
            WordListManager.sharedManager.setAced(wordList!)
            WordListManager.sharedManager.updateApplicationContext()
        }
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TestResultsViewController.endButtonPressed(_:)))
        navigationItem.rightBarButtonItem = completeButton
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateAxisForTraitCollection(traitCollection)
        testPercentageView.animate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateAxisForBoundsChange(view.bounds.size)
    }

    
    @objc func endButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
 
    
    // MARK:- Trait Collection Changes
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updateAxisForTraitCollection(newCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAxisForTraitCollection(self.view.traitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateAxisForBoundsChange(size)
    }


// MARK - Stack view orientation 
    func updateAxisForTraitCollection(_ traitCollection: UITraitCollection) {
        if traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact {
            resultsStackview.axis = NSLayoutConstraint.Axis.horizontal
        }
        else if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            updateAxisForBoundsChange(view.bounds.size)
        }
        else {
            resultsStackview.axis = NSLayoutConstraint.Axis.vertical
        }
    }
    
    func updateAxisForBoundsChange(_ size: CGSize) {
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            // iPad - check orientation in this case.
            if size.width > size.height {
                resultsStackview.axis = NSLayoutConstraint.Axis.horizontal
            }
            else {
                resultsStackview.axis = NSLayoutConstraint.Axis.vertical
            }
        }
    }

    
    func calculateCorrectAnswers() -> Int {
        var correctAnswers = 0
        for index in 0...test!.numberOfQuestions - 1 {
            let testQuestion = test?.questionAtIndex(index)
            if testQuestion?.userSelectedDefinition == testQuestion?.word.definition {
                correctAnswers += 1
            }
        }
        return correctAnswers
    }
    
    
    @IBAction func finishButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowReviewTableView" {
            if let testReviewTVC = segue.destination as? TestReviewTableViewController {
                testReviewTVC.test = self.test
                testReviewTVC.correctAnswers = calculateCorrectAnswers()
            }
        }
    }
    
    

    
}

