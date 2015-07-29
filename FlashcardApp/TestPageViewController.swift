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
        let completeButton : UIBarButtonItem = UIBarButtonItem(title: "End", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonPressed:")
        navigationItem.rightBarButtonItem = completeButton

        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavBarBG"), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "NavBarBG")
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.view.tintColor = UIColor(red:1.00, green:0.16, blue:0.41, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    func endButtonPressed(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testResultsViewController = storyboard.instantiateViewControllerWithIdentifier("TestResultsViewController") as! TestResultsViewController
        testResultsViewController.test = self.test
        navigationController?.pushViewController(testResultsViewController, animated: true)
        
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
