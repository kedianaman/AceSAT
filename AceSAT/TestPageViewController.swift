//
//  TestPageViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, TestViewControllerDelegate {

    var wordList: WordList? = nil {
        didSet {
            if wordList != nil {
                test = Test(wordList: wordList!)
            }
        }
    }
    private var test: Test!
    private var pageViewController: UIPageViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavBarBG"), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "NavBarBG")
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.view.tintColor = UIColor.ace_redColor()
        let cancelButton : UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
        navigationItem.leftBarButtonItem = cancelButton

    }
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        setUpPageControlAppearance()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    func completeButtonPressed(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testResultsViewController = storyboard.instantiateViewControllerWithIdentifier("TestResultsViewController") as! TestResultsViewController
        testResultsViewController.test = self.test
        testResultsViewController.wordList = self.wordList
        navigationController?.pushViewController(testResultsViewController, animated: true)
        
    }
    
    func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func setUpPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        let startViewController = testViewControllerAtIndex(0) as TestViewController
        pageViewController.setViewControllers([startViewController], direction: .Forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        pageViewController.willMoveToParentViewController(self)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
        
    }
    
    private func setUpPageControlAppearance() {
        let appearance = UIPageControl.appearance()
        appearance.currentPageIndicatorTintColor = UIColor.ace_redColor()
    }
    
    private func testViewControllerAtIndex(index: Int) -> TestViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testViewController = storyboard.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        testViewController.delegate = self
        if index == test.numberOfQuestions - 1 {
//            let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Complete", style: UIBarButtonItemStyle.Plain, target: self, action: "completeButtonPressed:")
//            navigationItem.rightBarButtonItem = completeButton
        }
        testViewController.testQuestion = test.questionAtIndex(index) // make random
        return testViewController
    }
    
    private func indexOfViewController(viewController: TestViewController) -> Int? {
        let question = viewController.testQuestion!
        return test.indexOfQuestion(question)
    }
    
    func addCompleteButton(testViewController: TestViewController) {
        let index = indexOfViewController(testViewController)
        if index == test.numberOfQuestions - 1 {
            let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Complete", style: UIBarButtonItemStyle.Plain, target: self, action: "completeButtonPressed:")
            navigationItem.rightBarButtonItem = completeButton

        }
    }
    
    // MARK: Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let testViewController = viewController as! TestViewController
        if let index = indexOfViewController(testViewController) {
            if index == 0 {
                return nil
            }
            return testViewControllerAtIndex(index-1)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let testViewController = viewController as! TestViewController
        if let index = indexOfViewController(testViewController) {
            if index >= test.numberOfQuestions-1 {
                return nil
            }
            return testViewControllerAtIndex(index+1)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return test.numberOfQuestions
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        let testViewController = pageViewController.viewControllers?.first as! TestViewController
        return indexOfViewController(testViewController)!
    }
}