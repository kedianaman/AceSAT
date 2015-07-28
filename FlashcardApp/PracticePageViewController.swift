//
//  PracticePageViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class PracticePageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var words = [String: String]()
    
    // MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.window?.tintColor = UIColor(red:0.10, green:0.82, blue:0.99, alpha:1.0)
    }
    
    // MARK:- View Setup
    
    override func loadView() {
        super.loadView()
        words = VocabWords().getWordsAtIndex(0)!
        setUpPageViewController()
        self.view.backgroundColor = UIColor.blackColor()
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
    
    private func flashCardViewControllerAtIndex(index: Int) -> PracticeFlashcardViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let flashCardViewController = storyboard.instantiateViewControllerWithIdentifier("PracticeFlashcardViewController") as! PracticeFlashcardViewController
        let vocabWord = words.keys.array[index]
        flashCardViewController.vocabWordText = vocabWord
        flashCardViewController.definitionWordText = words[vocabWord]
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
            if index == words.count {
                return nil
            }
            return self.flashCardViewControllerAtIndex(index)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return words.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
