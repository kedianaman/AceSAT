//
//  MainMenuViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/25/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var reviewButton: RoundGradientButton!
    @IBOutlet weak var practiceButton: RoundGradientButton!
    @IBOutlet weak var testButton: RoundGradientButton!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        titleText.attributedText = getTitleAttributedText()
        print(WordListManager.sharedManager.numberOfWordLists)
        
        updateGradientButtonColors()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController?.navigationBarHidden == false) {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
        updateAxisForTraitCollection(traitCollection)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleText.attributedText = getTitleAttributedText()
        updateAxisForBoundsChange(view.bounds.size)
    }
    
    
    // MARK:- View Setup
    
    private func updateGradientButtonColors() {
        reviewButton.gradient = CGGradientRef.ace_greenGradient()
        practiceButton.gradient = CGGradientRef.ace_blueGradient()
        testButton.gradient = CGGradientRef.ace_redGradient()
    }
    
    private func getTitleAttributedText() -> NSAttributedString {
        let dimension = min(view.bounds.size.height, view.bounds.size.width)
        
        let thinFont = UIFont.systemFontOfSize(dimension * 0.25, weight: UIFontWeightUltraLight)
        let lightFont = UIFont.systemFontOfSize(dimension * 0.25, weight: UIFontWeightLight)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.whiteColor()])
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "CE", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(dimension * 0.2, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName : UIColor.whiteColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "S", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_greenColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_blueColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "T", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_redColor()]))
        
        return mainTitle
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
    
    func updateAxisForTraitCollection(traitCollection: UITraitCollection) {
        if traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact {
            self.stackView.axis = UILayoutConstraintAxis.Horizontal
        }
        else if traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular {
            updateAxisForBoundsChange(view.bounds.size)
        }
        else {
            self.stackView.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    func updateAxisForBoundsChange(size: CGSize) {
        if traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular {
            // iPad - check orientation in this case.
            if size.width > size.height {
                self.stackView.axis = UILayoutConstraintAxis.Horizontal
            }
            else {
                self.stackView.axis = UILayoutConstraintAxis.Vertical
            }
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        updateAxisForBoundsChange(size)
    }
    
    // MARK:- Actions
    
    @IBAction func practiceButtonPressed(sender: UIButton) {
        let practicePageViewController = PracticePageViewController()
        let practiceNavigationController = UINavigationController(rootViewController: practicePageViewController)
        presentViewController(practiceNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func testButtonPressed(sender: UIButton) {
        let testPageViewController = TestPageViewController()
        let testNavigationController = UINavigationController(rootViewController: testPageViewController)
        self.presentViewController(testNavigationController, animated: true, completion: nil)
    }
    
}
