//
//  SoundManager.swift
//  MannDrops
//
//  Created by hackeru on 11/17/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit
import AVFoundation

class SoundManager: NSObject {
    
    //**********************NOTE: THIS CLASS IS NOT YET ACTIVE*********************************//
    
    static let shared = SoundManager()
    let popUrl: URL
    let popSound: AVAudioPlayer
    let waterSplashUrl: URL
    let waterSplashSound: AVAudioPlayer
    
    override init(){
        self.popUrl =  Bundle.main.url(forResource: "pop-sound-effect", withExtension: "wav")!
        self.popSound = try! AVAudioPlayer(contentsOf : popUrl)
        self.waterSplashUrl =  Bundle.main.url(forResource: "water-splash", withExtension: "wav")!
        self.waterSplashSound = try! AVAudioPlayer(contentsOf : popUrl)
    }
    
    public func playPopSound(){
        popSound.play()
    }
    
    public func playWaterSplashSound(){
        waterSplashSound.play()
    }
    
}
