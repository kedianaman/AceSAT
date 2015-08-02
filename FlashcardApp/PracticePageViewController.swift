//
//  PracticePageViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class PracticePageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pageViewController: UIPageViewController!
    var wordList = WordList()
    
    // MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonPressed:")
        navigationItem.rightBarButtonItem = doneButton
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavBarBG"), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "NavBarBG")
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.view.tintColor = UIColor.ace_blueColor()
    }
    
    // MARK:- View Setup
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        setUpPageControlAppearance()
        self.view.backgroundColor = UIColor.blackColor()
    }
    // MARK:- IB Action
    
    func doneButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func setUpPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let startViewController = flashCardViewControllerAtIndex(0) as PracticeFlashcardViewController
        let viewControllers = [startViewController]
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }
    
    private func setUpPageControlAppearance() {
        let appearance = UIPageControl.appearance()
        appearance.currentPageIndicatorTintColor = UIColor.ace_blueColor()
    }

    
    private func flashCardViewControllerAtIndex(index: Int) -> PracticeFlashcardViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let flashCardViewController = storyboard.instantiateViewControllerWithIdentifier("PracticeFlashcardViewController") as! PracticeFlashcardViewController
        let vocabWord = wordList[index]
        flashCardViewController.vocabWordText = vocabWord.word
        flashCardViewController.definitionWordText = vocabWord.definition
        flashCardViewController.indexOfView = index
        return flashCardViewController
    }
    
    // MARK: Page View Controller Data Source 
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let newViewController = pendingViewControllers.first as! PracticeFlashcardViewController
        let oldViewController = pageViewController.viewControllers?.first as! PracticeFlashcardViewController
        newViewController.showingDefinition = oldViewController.showingDefinition
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let practiceViewController = viewController as! PracticeFlashcardViewController
        if var index = practiceViewController.indexOfView {
            if index == 0 || index == NSNotFound {
                return nil
            }
            index--
            return self.flashCardViewControllerAtIndex(index)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let practiceViewController = viewController as! PracticeFlashcardViewController
        if var index = practiceViewController.indexOfView {
            index++
            if index == wordList.count {
                return nil
            }
            return self.flashCardViewControllerAtIndex(index)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return wordList.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
