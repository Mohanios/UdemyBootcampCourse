//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quesLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var quizBrain = QuizBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQues()
        
    }
    
    @IBAction func ansButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotRight = quizBrain.checkAnswer(userAnswer)
        
        if userGotRight {
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
        }
        quizBrain.nextQues()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateQues), userInfo: nil, repeats: false)
    }
    
    @objc func updateQues(){
        quesLabel.text = quizBrain.getQues()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getscore())"
        trueButton.backgroundColor = .clear
        falseButton.backgroundColor = . clear
        
    }
    
}

