//
//  AudioService.swift
//  Baggage
//
//  Created by Student on 15/02/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import Foundation
import AVFoundation


class AudioService {
    
    static var audioPlayer = AVAudioPlayer()
    
    static func Play(audio: String){
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: audio, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch {
            }
        } catch {
            print(error)
        }
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
    
    }

}
