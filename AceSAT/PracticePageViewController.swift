//
//  PracticePageViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class PracticePageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    fileprivate var pageViewController: UIPageViewController!
    var wordList = WordList()
    
    // MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(PracticePageViewController.doneButtonPressed(_:)))
        navigationItem.rightBarButtonItem = doneButton
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavBarBG"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "NavBarBG")
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.view.tintColor = UIColor.ace_blueColor()
    }

    // MARK:- View Setup
    
    override func loadView() {
        super.loadView()
        setUpPageViewController()
        setUpPageControlAppearance()
        self.view.backgroundColor = UIColor.black
    }
    
    // MARK:- Motion
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            let viewController = pageViewController.viewControllers?.first as! PracticeFlashcardViewController
            viewController.speakWord()
        }
    }
    
    // MARK:- IB Action
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let startViewController = flashCardViewControllerAtIndex(0) as PracticeFlashcardViewController
        let viewControllers = [startViewController]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    fileprivate func setUpPageControlAppearance() {
        let appearance = UIPageControl.appearance()
        appearance.currentPageIndicatorTintColor = UIColor.ace_blueColor()
    }

    
    fileprivate func flashCardViewControllerAtIndex(_ index: Int) -> PracticeFlashcardViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let flashCardViewController = storyboard.instantiateViewController(withIdentifier: "PracticeFlashcardViewController") as! PracticeFlashcardViewController
        let vocabWord = wordList[index]
        flashCardViewController.vocabWordText = vocabWord.word
        flashCardViewController.definitionWordText = vocabWord.definition
        flashCardViewController.indexOfView = index
        return flashCardViewController
    }
    
    // MARK: Page View Controller Data Source 
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let newViewController = pendingViewControllers.first as! PracticeFlashcardViewController
        let oldViewController = pageViewController.viewControllers?.first as! PracticeFlashcardViewController
        newViewController.showingDefinition = oldViewController.showingDefinition
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let practiceViewController = viewController as! PracticeFlashcardViewController
        if var index = practiceViewController.indexOfView {
            if index == 0 || index == NSNotFound {
                return nil
            }
            index -= 1
            return self.flashCardViewControllerAtIndex(index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let practiceViewController = viewController as! PracticeFlashcardViewController
        if var index = practiceViewController.indexOfView {
            index += 1
            if index == wordList.count {
                return nil
            }
            return self.flashCardViewControllerAtIndex(index)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return wordList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
