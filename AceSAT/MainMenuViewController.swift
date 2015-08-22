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
    @IBOutlet weak var listChooserButton: UIButton!
    
    @IBOutlet weak var wordListStackView: UIStackView!
    @IBOutlet weak var wordListPickerView: WordListPickerView!
    
    var currentlySelectedWordList: WordList {
        if let index = NSUserDefaults.standardUserDefaults().valueForKey("SelectedWordListKey") as? Int {
            return WordListManager.sharedManager.wordListAtIndex(index)
        } else {
            return WordListManager.sharedManager.wordListAtIndex(0)
        }
    }
    
    var currentlySelectedIndex: Int {
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "SelectedWordListKey")
        }
        get {
            if let index = NSUserDefaults.standardUserDefaults().valueForKey("SelectedWordListKey") as? Int {
                return index
            } else {
                return 0

            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.shadowImage = UIImage()

        wordListStackView.alpha = 0
        wordListPickerView.numberOfLists = WordListManager.sharedManager.numberOfWordLists
        wordListStackView.transform = CGAffineTransformMakeTranslation(0, -wordListStackView.bounds.size.height/4.0)
        
        listChooserButton.tintColor = UIColor.whiteColor()
        listChooserButton.setTitle(String(currentlySelectedIndex+1), forState: .Normal)
        
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
        updateTitleFontAndListChooserButton()
        updateAxisForBoundsChange(view.bounds.size)
    }
    
    
    // MARK:- View Setup
    
    private func updateGradientButtonColors() {
        reviewButton.gradient = CGGradientRef.ace_greenGradient()
        practiceButton.gradient = CGGradientRef.ace_blueGradient()
        testButton.gradient = CGGradientRef.ace_redGradient()
    }
    
    private func updateTitleFontAndListChooserButton() {
        let dimension = min(view.bounds.size.height, view.bounds.size.width)
        let thinFont = UIFont.systemFontOfSize(floor(dimension * 0.2), weight: UIFontWeightUltraLight)
        let lightFont = UIFont.systemFontOfSize(floor(dimension * 0.2), weight: UIFontWeightLight)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : UIColor.whiteColor()])
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "CE", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(floor(dimension * 0.15), weight: UIFontWeightUltraLight), NSForegroundColorAttributeName : UIColor.whiteColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "S", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_greenColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_blueColor()]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "T", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : UIColor.ace_redColor()]))
        
        titleText.attributedText = mainTitle

        listChooserButton.titleLabel?.font = UIFont.systemFontOfSize(floor(dimension * 0.1), weight: UIFontWeightLight)
        listChooserButton.layer.cornerRadius = listChooserButton.bounds.size.height/2
        listChooserButton.layer.masksToBounds = true

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
    @IBAction func listChooserButtonPressed(sender: AnyObject) {
        wordListPickerView.reloadComponents()
        let showWordListChooser = self.wordListStackView.alpha == 0
        if showWordListChooser == true {
            wordListPickerView.setSelectedRow(currentlySelectedIndex)
        }
        let buttons = [reviewButton, practiceButton, testButton]
        for button in buttons {
            let randomDuration = Double(random()%30)/50.0 + 0.4
            UIView.animateWithDuration(randomDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                button.transform = showWordListChooser ? CGAffineTransformMakeTranslation(0, self.wordListStackView.bounds.size.height + 20) : CGAffineTransformIdentity
                button.enabled = !showWordListChooser
            }, completion: nil)
        }
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.stackView.alpha = showWordListChooser ? 0.25 : 1.0
            self.wordListStackView.alpha = showWordListChooser ? 1.0 : 0.0
            
            self.wordListStackView.transform = showWordListChooser ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, -self.wordListStackView.bounds.size.height/4.0)

            if showWordListChooser {
                self.listChooserButton.setImage(UIImage(named: "Checkmark"), forState: .Normal)
                self.listChooserButton.setTitle("", forState: .Normal)
                self.wordListPickerView.reloadInputViews()
            }
            else {
                self.listChooserButton.setImage(nil, forState: .Normal)
                self.listChooserButton.setTitle(String(self.wordListPickerView.selectedNumberList+1), forState: .Normal)
                self.currentlySelectedIndex = self.wordListPickerView.selectedNumberList
            }
            
            }, completion: nil)
    }
    
    @IBAction func practiceButtonPressed(sender: UIButton) {
        let practicePageViewController = PracticePageViewController()
        currentlySelectedWordList.randomize()
        practicePageViewController.wordList = currentlySelectedWordList
        let practiceNavigationController = UINavigationController(rootViewController: practicePageViewController)
        presentViewController(practiceNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func testButtonPressed(sender: UIButton) {
        let testPageViewController = TestPageViewController()
        testPageViewController.wordList = currentlySelectedWordList
        let testNavigationController = UINavigationController(rootViewController: testPageViewController)
        self.presentViewController(testNavigationController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowReview" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let reviewViewController = navigationController.visibleViewController as! ReviewTableViewController
            reviewViewController.wordList = currentlySelectedWordList
        }
    }
    
}