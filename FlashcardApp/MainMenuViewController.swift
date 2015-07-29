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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController?.navigationBarHidden == false) {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.navigationController?.navigationBarHidden == true) {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    // MARK:- Attributed Title
    
    func getTitleAttributedText() -> NSAttributedString {
        let thinFont = UIFont.systemFontOfSize(72.0, weight: UIFontWeightUltraLight)
        let lightFont = UIFont.systemFontOfSize(72.0, weight: UIFontWeightLight)
        
        let whiteColor = UIColor.whiteColor()
        let greenColor = UIColor(red:0.51, green:0.98, blue:0.43, alpha:1.0)
        let blueColor = UIColor(red:0.10, green:0.82, blue:0.99, alpha:1.0)
        let redColor = UIColor(red:1.00, green:0.16, blue:0.41, alpha:1.0)
        
        let mainTitle = NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : thinFont, NSForegroundColorAttributeName : whiteColor])
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "CE", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(54.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName : whiteColor]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "S", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : greenColor]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "A", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : blueColor]))
        mainTitle.appendAttributedString(NSMutableAttributedString(string: "T", attributes: [NSFontAttributeName : lightFont, NSForegroundColorAttributeName : redColor]))
        
        return mainTitle
    }
    
    // MARK:- Actions
    
    @IBAction func practicleButtonPressed(sender: UIButton) {
        let practicePageViewController = PracticePageViewController()
        self.navigationController?.pushViewController(practicePageViewController, animated: true)
    }
    
    @IBAction func testButtonPressed(sender: UIButton) {
        let testPageViewController = TestPageViewController() as! TestPageViewController
        testPageViewController
        self.navigationController?.pushViewController(testPageViewController, animated: true)
        
    }
    
}
