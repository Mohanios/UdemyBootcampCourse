//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var calculatorBrain = CalculatorBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSlider(_ sender: UISlider) {
        let height = String(format: "%0.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
       let weight = String(Int(sender.value))
        weightLabel.text = "\(weight)kg"
    }
    
    @IBAction func clickedBMI(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBmi(height: height, weight: weight)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "goToResult" {
                let destinationVc = segue.destination as! ResultViewController
                destinationVc.valueBmi = calculatorBrain.getBmiValue()
                destinationVc.advice = calculatorBrain.getAdvice()
                destinationVc.color = calculatorBrain.getColor()
            }
            
        }
      
    
}

