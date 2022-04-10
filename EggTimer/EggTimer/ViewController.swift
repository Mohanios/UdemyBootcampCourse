//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggHardhess = ["Soft":300,"Medium":420,"Hard":720]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    
    @IBAction func eggPressed(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        
        progressBar.progress = 0.0
        totalTime = eggHardhess[hardness]!
        secondsPassed = 0
        titleLabel.text = hardness
        
        
        totalTime = eggHardhess[hardness]!
        print(totalTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            let progressTime = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = progressTime
            secondsPassed += 1
        }else{
            timer.invalidate()
            titleLabel.text = "DONE!!"
            playSound(sound:"alarm_sound")
        }
        
    }
    func playSound(sound:String) {
        let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
}



