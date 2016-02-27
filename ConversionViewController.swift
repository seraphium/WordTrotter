//
//  ConversionViewController.swift
//  WordTrotter
//
//  Created by Jackie Zhang on 16/2/27.
//  Copyright © 2016年 Jackie Zhang. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("ConversionViewController loaded")
    }
    
    override func viewWillAppear(animated: Bool) {
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH"
        let hourString = timeFormatter.stringFromDate(date)
        if let hour = Int(hourString) {
            if hour > 18 {
                view.backgroundColor = UIColor.blackColor()
            }
        }
        
    }
    
    let numberFormatter : NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else
        {
            return nil
        }
    }
    
    func updateCelsiusLabel()
    {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else{
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField){
    
        if let text = textField.text, number = numberFormatter.numberFromString(text)  {
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
    
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            
            let currentLocale = NSLocale.currentLocale()
            let decimalSeperator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
            
            let invalidCharacters = NSCharacterSet(charactersInString: "01234567890\(decimalSeperator)").invertedSet
            if let _ = string.rangeOfCharacterFromSet(invalidCharacters){
                return false;
            }
            
                 let existTextHasDecimalSeperator = textField.text?.rangeOfString(decimalSeperator)
            let replacementStringHasDecimalSeperator = string.rangeOfString(decimalSeperator)
            if existTextHasDecimalSeperator != nil && replacementStringHasDecimalSeperator != nil {
                return false
            } else {
                return true
            }
            
    }
    
}
