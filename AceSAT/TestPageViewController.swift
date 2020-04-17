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
    fileprivate var test: Test!
    fileprivate var pageViewController: UIPageViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavBarBG"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "NavBarBG")
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.view.tintColor = UIColor.ace_redColor()
        let cancelButton : UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TestPageViewController.cancelButtonPressed(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        setUpPageControlAppearance()
        self.view.backgroundColor = UIColor.black
    }
    
    @objc func completeButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testResultsViewController = storyboard.instantiateViewController(withIdentifier: "TestResultsViewController") as! TestResultsViewController
        testResultsViewController.test = self.test
        testResultsViewController.wordList = self.wordList
        navigationController?.pushViewController(testResultsViewController, animated: true)
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setUpPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        let startViewController = testViewControllerAtIndex(0) as TestViewController
        pageViewController.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        pageViewController.willMove(toParent: self)
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
    }
    
    fileprivate func setUpPageControlAppearance() {
        let appearance = UIPageControl.appearance()
        appearance.currentPageIndicatorTintColor = UIColor.ace_redColor()
    }
    
    fileprivate func testViewControllerAtIndex(_ index: Int) -> TestViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testViewController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        testViewController.delegate = self
        testViewController.testQuestion = test.questionAtIndex(index) // make random
        return testViewController
    }
    
    fileprivate func indexOfViewController(_ viewController: TestViewController) -> Int? {
        let question = viewController.testQuestion!
        return test.indexOfQuestion(question)
    }
    
    func addCompleteButton(_ testViewController: TestViewController) {
        let index = indexOfViewController(testViewController)
        if index == test.numberOfQuestions - 1 {
            let completeButton : UIBarButtonItem = UIBarButtonItem(title: "Complete", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TestPageViewController.completeButtonPressed(_:)))
            navigationItem.rightBarButtonItem = completeButton

        }
    }
    
    // MARK: Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let testViewController = viewController as! TestViewController
        if let index = indexOfViewController(testViewController) {
            if index == 0 {
                return nil
            }
            return testViewControllerAtIndex(index-1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let testViewController = viewController as! TestViewController
        if let index = indexOfViewController(testViewController) {
            if index >= test.numberOfQuestions-1 {
                return nil
            }
            return testViewControllerAtIndex(index+1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return test.numberOfQuestions
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let testViewController = pageViewController.viewControllers?.first as! TestViewController
        return indexOfViewController(testViewController)!
    }
}
