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
        
        updateGradientButtonColors()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController?.navigationBarHidden == false) {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    // MARK:- View Setup
    
    private func updateGradientButtonColors() {
        reviewButton.gradient = CGGradientRef.ace_greenGradient()
        practiceButton.gradient = CGGradientRef.ace_blueGradient()
        testButton.gradient = CGGradientRef.ace_redGradient()
    }
    
    private func getTitleAttributedText() -> NSAttributedString {
        let thinFont = UIFont.systemFontOfSize(72.0, weight: UIFontWeightUltraLight)
        let lightFont = UIFont.systemFontOfSize(72.0, weight: UIFontWeightLight)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.whiteColor()])
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "CE", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(54.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName : UIColor.whiteColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "S", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_greenColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_blueColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "T", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_redColor()]))
        
        return mainTitle
    }
    
    // MARK:- Trait Collection Changes
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        updateAxisForTraitCollection(newCollection, size: view.bounds.size)
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAxisForTraitCollection(self.view.traitCollection, size: view.bounds.size)
    }
    
    func updateAxisForTraitCollection(traitCollection: UITraitCollection, size: CGSize) {
        if traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact {
            self.stackView.axis = UILayoutConstraintAxis.Horizontal
        }
        else if traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular {
            // iPad - check orientation in this case.
            if size.width > size.height {
                self.stackView.axis = UILayoutConstraintAxis.Horizontal
            }
            else {
                self.stackView.axis = UILayoutConstraintAxis.Vertical
            }
        }
        else {
            self.stackView.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        updateAxisForTraitCollection(self.traitCollection, size: size)
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
