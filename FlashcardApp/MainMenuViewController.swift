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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
                titleText.attributedText = getTitleAttributedText()
        self.navigationController?.navigationBarHidden = true
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
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        if newCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact {
            self.stackView.axis = UILayoutConstraintAxis.Horizontal
        }
        else {
            self.stackView.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    func getTitleAttributedText() -> NSAttributedString {
        let mainTitle = NSMutableAttributedString(string: "AceSAT")
        mainTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, 3))
        mainTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor(red:0.51, green:0.98, blue:0.43, alpha:1.0), range: NSMakeRange(3, 1))
        mainTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor(red:0.10, green:0.82, blue:0.99, alpha:1.0), range: NSMakeRange(4, 1))
        mainTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor(red:1.00, green:0.16, blue:0.41, alpha:1.0), range: NSMakeRange(5, 1))
        
        return mainTitle
    }
}
