//
//  SoundHelper.swift
//  Game 8
//
//  Created by Petar Stanev on 01/05/2018.
//  Copyright © 2018 Petar Stanev. All rights reserved.
//

import Foundation
import AVFoundation

class SoundHelper {
    
    var player: AVAudioPlayer?
    
    
    func playSound(soundName: String) {
        //print("sound played - " + soundName)
        
        let defaults = UserDefaults.standard
        let soundValue = defaults.bool(forKey: "sound")
        
        if soundValue {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav", subdirectory: "Sound") else {
                print("url not found")
                return
            }
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
            
                //player.prepareToPlay()
                player.play()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
}
