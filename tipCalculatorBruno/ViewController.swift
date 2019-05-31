//
//  ViewController.swift
//  tipCalculatorBruno
//
//  Created by Bruno Portela on 5/27/19.
//  Copyright © 2019 Bruno Portela. All rights reserved.
//

import UIKit
import Foundation
//testing cocoapods capabilities
import ChameleonFramework

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        billField.placeholder = numberFormatter.string(from: NSNumber(value: 0))
        billField.becomeFirstResponder()
        self.navigationController?.hidesNavigationBarHairline = true
    }
    
    lazy var numberFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter
    }()
    
    var amount = 0
    let tipPercentages = [0.15, 0.18, 0.2]
    
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billAmount: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var division: UIView!
    @IBOutlet weak var background: UIView!
    
    @IBAction func onTap(_ sender: Any) {
        //dismiss keyboard when tapping on blank spaces
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        
        guard let text = billField.text else { return }
        
        
        var array = text.compactMap({ Int(String($0)) })
        
        //stop receiving numbers after the 10th
        if array.count > 10 {
            array.removeLast()
            let alertController = UIAlertController(title: "Wow! That's a huge bill!", message: "Maybe you should consider a super computer to handle that tip calculation. 10 numbers is as far as I can go. Sorry. :(.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        let num = Double(array.reduce(0, {($0 * 10) + $1})) / 100
        let tip = num * tipPercentages[tipControl.selectedSegmentIndex]
        let total = num + tip
        
        billField.text = numberFormatter.string(from: num as NSNumber)
        tipLabel.text = numberFormatter.string(from: tip as NSNumber)
        totalLabel.text = numberFormatter.string(from: total as NSNumber)
    }
    
    fileprivate func makeItDark() {
        if UserDefaults.standard.integer(forKey: "defaultTheme") == 0 {
            billField.keyboardAppearance = UIKeyboardAppearance.light
            background.backgroundColor = UIColor.white
        } else {
            billField.keyboardAppearance = UIKeyboardAppearance.dark
            background.backgroundColor = UIColor.black
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Get default tip value
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultTip")
        //turn dark mode or/off according to default settings
        makeItDark()
        //recalculate tip, in case default tip was changed
        calculateTip(self)
        
        
    }
    
}

