//
//  ViewController.swift
//  TipCalc
//
//  Created by Weihong Chen on 26/03/2015.
//  Copyright (c) 2015 Weihong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var amountBeforeTaxTextField: UITextField!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var taxPercentageSlider: UISlider!
    @IBOutlet weak var peopleNumberSlider: UISlider!
    
    @IBOutlet weak var taxPercentageTextField: UITextField!
    @IBOutlet weak var peopleNumberTextField: UITextField!
    
    
    @IBAction func buttonTapped(sender: AnyObject) {
         calcTip()
    }
    
    let tipCalc = TipCalc(amountBeforeTax: 25.00, tipPercentage: 0.2, taxPercentage: 0.1, howManyPeople: 1)
    var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountBeforeTaxTextField.delegate = self
        tipPercentageTextField.delegate = self
        
        taxPercentageTextField.text = "0.1"
        peopleNumberTextField.text = "1"
        
        amountBeforeTaxTextField.text = String(format: "%0.2f",
            arguments:
            [tipCalc.amountBeforeTax])
        tipPercentageTextField.text = String(format: "%0.2f", arguments:
            [tipCalc.tipPercentage])
        textFields = [amountBeforeTaxTextField, tipPercentageTextField]
        
        tipPercentageSlider.maximumValue = 0.25
        tipPercentageSlider.minimumValue = 0.15
        tipPercentageSlider.addTarget(self, action: "tipPercentageSliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        taxPercentageSlider.maximumValue = 0.1
        taxPercentageSlider.minimumValue = 0.0
        taxPercentageSlider.addTarget(self, action: "taxPercentageSliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        peopleNumberSlider.maximumValue = 100
        peopleNumberSlider.minimumValue = 0
        peopleNumberSlider.addTarget(self, action: "peopleNumberValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tipPercentageSliderValueChanged(sender: UISlider){
        
        var value = String(format: "%0.2f", arguments: [sender.value])
        tipPercentageTextField.text = value
        calcTip()
    }

    func taxPercentageSliderValueChanged(sender: UISlider){
        var value = String(format: "%0.2f", arguments: [sender.value])
        taxPercentageTextField.text = value
        calcTip()
    }
    
    func peopleNumberValueChanged(sender: UISlider){
    
        var value = "\(sender.value)" as NSString
        var peopleNumber = value.intValue
        peopleNumberTextField.text = "\(peopleNumber)"
        calcTip()
    }
    
    func calcTip(){
        tipCalc.tipPercentage = (tipPercentageTextField.text as
            NSString).floatValue
        tipCalc.amountBeforeTax = (amountBeforeTaxTextField.text as
            NSString).floatValue
        tipCalc.howManyPeople = (peopleNumberTextField.text as NSString).integerValue
        tipCalc.taxPercentage = (taxPercentageTextField.text as NSString).floatValue
        
        
        
        tipCalc.calculateTip()
        tipCalc.calculateAmountAfterTax()
        tipCalc.calculateTotalIncludedTaxAndTip()
        tipCalc.averageForPerPerson()
        
        resultLabel.text = "Amount after tax: \(tipCalc.amountAfterTax), Your tip: \(tipCalc.tipAmount), Your total bill: \(tipCalc.amountTotal), averagePerPerson: \(tipCalc.average)."
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let textFieldArray = textFields as NSArray
        let i = textFieldArray.indexOfObject(textField)
        if i < textFieldArray.count - 1 {
            let newTextField = textFieldArray[i+1] as UITextField
            newTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            calcTip()
        }
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}

