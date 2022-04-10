//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Mohanraj on 06/04/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi : BMI?
    
    func getAdvice()->String{
        return bmi?.advice ?? "No Advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
    
    func getBmiValue()-> String{
        let bmi1decimal = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmi1decimal
    }
    
    mutating func calculateBmi(height: Float, weight: Float){
        let bmiValue = weight / (height*height)
        print(bmiValue)
        if bmiValue < 18.9 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: .blue)
        }else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: .green)
        }else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: .red)
        }
    }
    
    
    
}
