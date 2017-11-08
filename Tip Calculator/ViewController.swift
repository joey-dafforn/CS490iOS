//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Joey Dafforn on 11/6/17.
//  Copyright © 2017 Joey Dafforn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billSlider: UISlider!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        let totalValue = defaults.float(forKey: "total")
        let tipValue = defaults.float(forKey: "tip")
        let billValue = defaults.string(forKey: "bill")
        let billSliderValue = defaults.float(forKey: "billSlider")
        billField.text = billValue
        tipLabel.text = String("$" + String(tipValue))
        totalLabel.text = String("$" + String(totalValue))
        billSlider.value = billSliderValue
        tipPercentageLabel.text = String(format: "%d%%", Int(billSlider.value))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        let bill = Double(billField.text!) ?? 0
        let output = Int(billSlider.value)
        billSlider.value = Float(output)
        tipPercentageLabel.text = String(format: "%d%%", Int(billSlider.value))
        let tip = bill * (Double(billSlider.value)/100)
        let total = Float(bill + tip)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        defaults.set(total, forKey: "total")
        defaults.set(tip, forKey: "tip")
        defaults.set(bill, forKey: "bill")
        defaults.set(billSlider.value, forKey: "billSlider")
        defaults.synchronize()
    }
}

