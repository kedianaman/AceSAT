//
//  WordListPickerView.swift
//  FlashcardApp
//
//  Created by Naman Kedia on 8/2/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import UIKit

class WordListPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var numberOfLists: Int = 0 {
        didSet {
            pickerView?.reloadAllComponents()
        }
    }
    
    var selectedNumberList: Int {
        if pickerView == nil {
            return 0
        }
        return pickerView.selectedRowInComponent(0)
    }
    
    private var pickerView: UIPickerView!
    private var selectionIndicatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if pickerView == nil {
            pickerView = UIPickerView(frame: CGRectMake(0, 0, bounds.size.height, bounds.size.width))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            self.addSubview(pickerView)
        }
        
        if selectionIndicatorView == nil {
            selectionIndicatorView = UIView(frame: CGRectMake((bounds.size.width - bounds.size.height)/2.0, 0, bounds.size.height, bounds.size.height))
            selectionIndicatorView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
            selectionIndicatorView.userInteractionEnabled = false
            self.addSubview(selectionIndicatorView)
        }
        
        pickerView.transform = CGAffineTransformIdentity
        pickerView.frame = CGRectMake(0, 0, bounds.size.height, bounds.size.width)
        pickerView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        pickerView.center = CGPointMake(bounds.size.width/2.0, bounds.size.height/2.0)
        
        pickerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).CGColor
        pickerView.layer.borderWidth = 1.0
        
        selectionIndicatorView.frame = CGRectMake((bounds.size.width - bounds.size.height)/2.0, 0, bounds.size.height, bounds.size.height)

        pickerView.reloadAllComponents()
    }
    
    // MARK:- UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numberOfLists
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return bounds.size.height
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var viewForRow: UILabel?
        if let reuseView = view {
            if view?.isKindOfClass(UILabel) == true {
                viewForRow = reuseView as? UILabel
            }
        }
        if viewForRow == nil {
            viewForRow = UILabel()
            viewForRow!.textColor = UIColor.whiteColor()
            viewForRow!.textAlignment = .Center
            viewForRow!.numberOfLines = 0
        }
        
        let wordList = WordListManager.sharedManager.wordListAtIndex(row)
        
        let fontSize = (floor(11/40.0 * bounds.size.height))
        let listFont = UIFont.systemFontOfSize(fontSize)
        let starFont = UIFont.systemFontOfSize(fontSize * 0.75)
        
        if WordListManager.sharedManager.getAced(wordList) == true {
            let attributedText = NSMutableAttributedString(string: "\n", attributes: [NSFontAttributeName : starFont])
            attributedText.appendAttributedString(NSAttributedString(string: "\(row+1)\n", attributes: [NSFontAttributeName: listFont, NSForegroundColorAttributeName:UIColor.whiteColor() ]))
            attributedText.appendAttributedString(NSAttributedString(string: "★", attributes: [NSFontAttributeName: starFont, NSForegroundColorAttributeName:UIColor.orangeColor() ]))
            viewForRow!.attributedText = attributedText
        }
        else {
            viewForRow!.text = String(row+1)
            viewForRow!.font = listFont
        }
        
        
        viewForRow!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        viewForRow!.sizeToFit()
        
        return viewForRow!
    }
}
