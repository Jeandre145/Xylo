//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?

    @IBAction func keyPressed(_ sender: UIButton) {
        setupAudioPlayer(buttonTitleLabelText: sender.currentTitle!)
        
        //set on-press opacity using Alpha property to 0.5 for a fade out effect.
        sender.alpha = 0.5
        
        //then set opacity back to 1 after a 0.2 second delay
        let delayInSeconds = 0.2
        Timer.scheduledTimer(withTimeInterval: delayInSeconds, repeats: false) {_ in 
            sender.alpha = 1
        }
    }
    
    func setupAudioPlayer(buttonTitleLabelText: String) {
        //getting the sound file
        guard let soundURL = Bundle.main.url(forResource: buttonTitleLabelText, withExtension: "wav") else { return }
        
        do {
            //set playback mode catagory as a primary sound. This will play audio even if the phone is set to silent.
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            
            try AVAudioSession.sharedInstance().setActive(true)
            
            //play the actual sound that was selected using the selected playback mode/catagory.
            player = try AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

