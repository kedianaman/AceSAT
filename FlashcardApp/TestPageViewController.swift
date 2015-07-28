//
//  TestPageViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/27/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.window?.tintColor = UIColor(red:1.00, green:0.16, blue:0.41, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    

    let wordList = WordListManager.sharedManager.wordListAtIndex(0)
    var pageViewController: UIPageViewController!

    
    func testViewControllerAtIndex(index: Int) -> TestViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testViewController = storyboard.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        testViewController.setUpAtIndex(index, wordList: wordList)
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
            if index == wordList.numberOfWords() {
                return nil
            }
            return testViewControllerAtIndex(index)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return wordList.numberOfWords()
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
