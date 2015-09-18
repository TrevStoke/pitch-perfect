//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Trevor Adams on 17/09/2015.
//  Copyright © 2015 Trevor Adams. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        // Do any additional setup after loading the view.
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint:"wav")
            audioPlayer.enableRate = true
        } catch {
            print("Error occurred loading sound into AudioPlayer")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        stopAndResetAudioEngine()
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    @IBAction func playFast(sender: UIButton) {
        stopAndResetAudioEngine()
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        stopAndResetAudioEngine()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
