//
//  TintColorLabel.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 7/30/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class TintColorLabel: UILabel {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        self.textColor = self.tintColor
    }
}