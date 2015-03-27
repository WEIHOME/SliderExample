//
//  TipCalc.swift
//  TipCalc
//
//  Created by Weihong Chen on 26/03/2015.
//  Copyright (c) 2015 Weihong. All rights reserved.
//

import Foundation

class TipCalc {
    
    var tipAmount: Float = 0
    var taxAmount: Float = 0
    
    var amountBeforeTax: Float = 0
    var amountAfterTax: Float = 0
    
    var amountTotal: Float = 0
    
    var tipPercentage: Float = 0
    var taxPercentage: Float = 0
    var howManyPeople: Int = 0
    
    var average: Float = 0
    
    init(amountBeforeTax:Float, tipPercentage:Float, taxPercentage:Float, howManyPeople:Int) {
        self.amountBeforeTax = amountBeforeTax
        self.tipPercentage = tipPercentage
        self.taxPercentage = taxPercentage
        self.howManyPeople = howManyPeople
    }
    
    func calculateTip() {
        tipAmount = amountBeforeTax * tipPercentage
    }

    
    func calculateTotalIncludedTaxAndTip(){
        amountTotal = amountBeforeTax * taxPercentage + tipAmount + amountBeforeTax
    }
    
    func averageForPerPerson(){
        average = amountTotal / Float(howManyPeople)
    }
    
    func calculateAmountAfterTax(){
        amountAfterTax = amountBeforeTax * taxPercentage + amountBeforeTax
    }
}