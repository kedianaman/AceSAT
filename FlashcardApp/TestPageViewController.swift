//
//  TestPageViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    let test = Test(wordList: WordListManager.sharedManager.wordListAtIndex(5))
    var pageViewController: UIPageViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Complete", style: UIBarButtonItemStyle.Plain, target: self, action: "completed:")
        navigationItem.rightBarButtonItem = completeButton

        navigationController?.view.window?.tintColor = UIColor(red:1.00, green:0.16, blue:0.41, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    @IBAction func reviewUnwindSegueAction(segue: UIStoryboardSegue) {
        print("unwind back")
    }

    func completed(sender: UIBarButtonItem) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testResultsViewController = storyboard.instantiateViewControllerWithIdentifier("TestResultsViewController") as! TestResultsViewController
        let results = testResults()
        testResultsViewController.correctText = "\(results.correctAnswers) correct"
        testResultsViewController.wrongText = "\(results.incorrectAnswers) incorrect"
        testResultsViewController.unansweredText = "\(results.unanswered) unanswered"
        let percentage = Double(results.correctAnswers) / Double(test.numberOfQuestions) * 100.0
        testResultsViewController.percentageText = "\(Int(percentage)) %"
        navigationController?.pushViewController(testResultsViewController, animated: true)
        
    }
    
    func testResults() -> (correctAnswers: Int, incorrectAnswers: Int, unanswered: Int) {
        var correctAnswers = 0
        var incorrectAnswers = 0
        var unanswered = 0
        for index in 0...test.numberOfQuestions - 1 {
            let testViewController = testViewControllerAtIndex(index) as! TestViewController
            if testViewController.testQuestion?.userSelectedDefinition == nil {
                unanswered++
            }
            else if testViewController.testQuestion?.userSelectedDefinition == testViewController.testQuestion?.word.definition {
                correctAnswers++
            } else {
                incorrectAnswers++
            }
        }
        return (correctAnswers, incorrectAnswers, unanswered)

    }
    
    
    func testViewControllerAtIndex(index: Int) -> TestViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testViewController = storyboard.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        testViewController.testQuestion = test.questionAtIndex(index)
        testViewController.viewControllerIndex = index
        return testViewController
    }
    
    func setUpPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        let startViewController = testViewControllerAtIndex(0) as TestViewController
        let viewControllers = [startViewController]
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)

    }
    
    
    
    // MARK: Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let testViewController = viewController as! TestViewController
        if var index = testViewController.viewControllerIndex {
            if index == 0 || index == NSNotFound {
                return nil
            }
            index--
            return testViewControllerAtIndex(index)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let testViewController = viewController as! TestViewController
        if var index = testViewController.viewControllerIndex {
            index++
            if index == test.numberOfQuestions {
                return nil
            }
            return testViewControllerAtIndex(index)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return test.numberOfQuestions
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
