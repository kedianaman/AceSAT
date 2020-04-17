//
//  MainMenuViewController.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/25/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit
import WatchConnectivity

class MainMenuViewController: UIViewController, WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("session inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("session active")
    }
    
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState)
    }
    


    var session: WCSession!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var reviewButton: RoundGradientButton!
    @IBOutlet weak var practiceButton: RoundGradientButton!
    @IBOutlet weak var testButton: RoundGradientButton!    
    @IBOutlet weak var listChooserButton: UIButton!
    
    @IBOutlet weak var wordListStackView: UIStackView!
    @IBOutlet weak var wordListPickerView: WordListPickerView!
    
    var currentlySelectedWordList: WordList {
        if let index = UserDefaults.standard.value(forKey: "SelectedWordListKey") as? Int {
            return WordListManager.sharedManager.wordListAtIndex(index)
        } else {
            return WordListManager.sharedManager.wordListAtIndex(0)
        }
    }
    
    var currentlySelectedIndex: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "SelectedWordListKey")
        }
        get {
            if let index = UserDefaults.standard.value(forKey: "SelectedWordListKey") as? Int {
                return index
            } else {
                return 0

            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWatchData()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        wordListStackView.alpha = 0
        wordListPickerView.numberOfLists = WordListManager.sharedManager.numberOfWordLists
        wordListStackView.transform = CGAffineTransform(translationX: 0, y: -wordListStackView.bounds.size.height/4.0)
        
        listChooserButton.tintColor = UIColor.white
        listChooserButton.setTitle(String(currentlySelectedIndex+1), for: UIControl.State())
        
        updateGradientButtonColors()
    
    }
    
    func updateWatchData() {
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
        WordListManager.sharedManager.updateApplicationContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController?.isNavigationBarHidden == false) {
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
    
    fileprivate func updateGradientButtonColors() {
        reviewButton.gradient = CGGradient.ace_greenGradient()
        practiceButton.gradient = CGGradient.ace_blueGradient()
        testButton.gradient = CGGradient.ace_redGradient()
    }
    
    fileprivate func updateTitleFontAndListChooserButton() {
        let dimension = min(view.bounds.size.height, view.bounds.size.width)
        let thinFont = UIFont.systemFont(ofSize: floor(dimension * 0.2), weight: UIFont.Weight.ultraLight)
        let lightFont = UIFont.systemFont(ofSize: floor(dimension * 0.2), weight: UIFont.Weight.light)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSAttributedString.Key.font : thinFont, NSAttributedString.Key.foregroundColor : UIColor.white])
        mainTitle.append(NSMutableAttributedString(string: "CE", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: floor(dimension * 0.15), weight: UIFont.Weight.ultraLight), NSAttributedString.Key.foregroundColor : UIColor.white]))
        mainTitle.append(NSMutableAttributedString(string: "S", attributes: [NSAttributedString.Key.font : lightFont, NSAttributedString.Key.foregroundColor : UIColor.ace_greenColor()]))
        mainTitle.append(NSMutableAttributedString(string: "A", attributes: [NSAttributedString.Key.font : lightFont, NSAttributedString.Key.foregroundColor : UIColor.ace_blueColor()]))
        mainTitle.append(NSMutableAttributedString(string: "T", attributes: [NSAttributedString.Key.font : lightFont, NSAttributedString.Key.foregroundColor : UIColor.ace_redColor()]))
        
        titleText.attributedText = mainTitle

        listChooserButton.titleLabel?.font = UIFont.systemFont(ofSize: floor(dimension * 0.1), weight: UIFont.Weight.light)
        listChooserButton.layer.cornerRadius = listChooserButton.bounds.size.height/2
        listChooserButton.layer.masksToBounds = true

    }
    
    // MARK:- Trait Collection Changes
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updateAxisForTraitCollection(newCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAxisForTraitCollection(self.view.traitCollection)
    }
    
    func updateAxisForTraitCollection(_ traitCollection: UITraitCollection) {
        if traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact {
            self.stackView.axis = NSLayoutConstraint.Axis.horizontal
        }
        else if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            updateAxisForBoundsChange(view.bounds.size)
        }
        else {
            self.stackView.axis = NSLayoutConstraint.Axis.vertical
        }
    }
    
    func updateAxisForBoundsChange(_ size: CGSize) {
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            // iPad - check orientation in this case.
            if size.width > size.height {
                self.stackView.axis = NSLayoutConstraint.Axis.horizontal
            }
            else {
                self.stackView.axis = NSLayoutConstraint.Axis.vertical
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateAxisForBoundsChange(size)
    }
    
    // MARK:- Actions
    @IBAction func listChooserButtonPressed(_ sender: AnyObject) {
        wordListPickerView.reloadComponents()
        let showWordListChooser = self.wordListStackView.alpha == 0
        if showWordListChooser == true {
            wordListPickerView.setSelectedRow(currentlySelectedIndex)
        }
        let buttons = [reviewButton, practiceButton, testButton]
        for button in buttons {
            let randomDuration = Double(Int(arc4random())%30)/50.0 + 0.4
            UIView.animate(withDuration: randomDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
                button?.transform = showWordListChooser ? CGAffineTransform(translationX: 0, y: self.wordListStackView.bounds.size.height + 20) : CGAffineTransform.identity
                button?.isEnabled = !showWordListChooser
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            
            self.stackView.alpha = showWordListChooser ? 0.25 : 1.0
            self.wordListStackView.alpha = showWordListChooser ? 1.0 : 0.0
            
            self.wordListStackView.transform = showWordListChooser ? CGAffineTransform.identity : CGAffineTransform(translationX: 0, y: -self.wordListStackView.bounds.size.height/4.0)

            if showWordListChooser {
                self.listChooserButton.setImage(UIImage(named: "Checkmark"), for: UIControl.State())
                self.listChooserButton.setTitle("", for: UIControl.State())
                self.wordListPickerView.reloadInputViews()
            }
            else {
                self.listChooserButton.setImage(nil, for: UIControl.State())
                self.listChooserButton.setTitle(String(self.wordListPickerView.selectedNumberList+1), for: UIControl.State())
                self.currentlySelectedIndex = self.wordListPickerView.selectedNumberList
            }
            
            }, completion: nil)
    }
    
    @IBAction func practiceButtonPressed(_ sender: UIButton) {
        let practicePageViewController = PracticePageViewController()
        currentlySelectedWordList.randomize()
        practicePageViewController.wordList = currentlySelectedWordList
        let practiceNavigationController = UINavigationController(rootViewController: practicePageViewController)
        practiceNavigationController.modalPresentationStyle = .fullScreen
        present(practiceNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        let testPageViewController = TestPageViewController()
        testPageViewController.wordList = currentlySelectedWordList
        let testNavigationController = UINavigationController(rootViewController: testPageViewController)
        testNavigationController.modalPresentationStyle = .fullScreen
        self.present(testNavigationController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowReview" {
            let navigationController = segue.destination as! UINavigationController
            let reviewViewController = navigationController.visibleViewController as! ReviewTableViewController
            reviewViewController.wordList = currentlySelectedWordList
        }
    }
    
}
