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
        return pickerView.selectedRow(inComponent: 0)
    }
    
    func reloadComponents() {
        pickerView.reloadAllComponents()
    }
    
    func setSelectedRow(_ row: Int) {
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    fileprivate var pickerView: UIPickerView!
    fileprivate var selectionIndicatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if pickerView == nil {
            pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: bounds.size.height, height: bounds.size.width))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            self.addSubview(pickerView)
        }
        
        if selectionIndicatorView == nil {
            selectionIndicatorView = UIView(frame: CGRect(x: (bounds.size.width - bounds.size.height)/2.0, y: 0, width: bounds.size.height, height: bounds.size.height))
            selectionIndicatorView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
            selectionIndicatorView.isUserInteractionEnabled = false
            self.addSubview(selectionIndicatorView)
        }
        
        pickerView.transform = CGAffineTransform.identity
        pickerView.frame = CGRect(x: 0, y: 0, width: bounds.size.height, height: bounds.size.width)
        pickerView.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        pickerView.center = CGPoint(x: bounds.size.width/2.0, y: bounds.size.height/2.0)
        
        pickerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        pickerView.layer.borderWidth = 1.0
        
        selectionIndicatorView.frame = CGRect(x: (bounds.size.width - bounds.size.height)/2.0, y: 0, width: bounds.size.height, height: bounds.size.height)

        pickerView.reloadAllComponents()
        
        pickerView.setNeedsLayout()
    }
    
    // MARK:- UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numberOfLists
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return bounds.size.height
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var viewForRow: UILabel?
        if let reuseView = view {
            if view?.isKind(of: UILabel.self) == true {
                viewForRow = reuseView as? UILabel
            }
        }
        if viewForRow == nil {
            viewForRow = UILabel()
            viewForRow!.textColor = UIColor.white
            viewForRow!.textAlignment = .center
            viewForRow!.numberOfLines = 0
        }
        
        let wordList = WordListManager.sharedManager.wordListAtIndex(row)
        
        let fontSize = (floor(11/40.0 * bounds.size.height))
        let listFont = UIFont.systemFont(ofSize: fontSize)
        let starFont = UIFont.systemFont(ofSize: fontSize * 0.75)
        
        if WordListManager.sharedManager.getAced(wordList) == true {
            let attributedText = NSMutableAttributedString(string: "\n", attributes: [NSFontAttributeName : starFont])
            attributedText.append(NSAttributedString(string: "\(row+1)\n", attributes: [NSFontAttributeName: listFont, NSForegroundColorAttributeName:UIColor.white ]))
            attributedText.append(NSAttributedString(string: "★", attributes: [NSFontAttributeName: starFont, NSForegroundColorAttributeName:UIColor.orange ]))
            viewForRow!.attributedText = attributedText
        }
        else {
            viewForRow!.text = String(row+1)
            viewForRow!.font = listFont
        }
        
        
        viewForRow!.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        viewForRow!.sizeToFit()
        
        return viewForRow!
    }
}
