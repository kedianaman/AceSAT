//
//  TestReviewTableViewCell.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/29/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TestReviewCellLabel: UILabel {

    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var bounds = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        if bounds.size.height != 0 {
            bounds.size.height += 4.0
        }
        return bounds
    }
    
}

class TestReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userSelectedCellZeroHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordLabel: TestReviewCellLabel!
    @IBOutlet weak var correctDefinitionLabel: TestReviewCellLabel!
    @IBOutlet weak var userSelectedDefinitionLabel: TestReviewCellLabel!
    @IBOutlet weak var crossImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wordLabel.textColor = UIColor.ace_redColor()
    }
    
    func setUserSelectedDefinitionText(text:String?) {
        userSelectedDefinitionLabel.text = text
        userSelectedCellZeroHeightConstraint.active = (text == nil)
        if text == nil {
            crossImage.image = nil
        } else {
            crossImage.image = UIImage(named: "Cross")
        }
    }
}
