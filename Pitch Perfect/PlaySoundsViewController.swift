//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Trevor Adams on 17/09/2015.
//  Copyright © 2015 Trevor Adams. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    @IBOutlet weak var stopButton: UIButton!
    
    func configureViewToStart() {
        stopButton.hidden = true
    }
    
    func configureViewToPlay() {
        stopButton.hidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        // Do any additional setup after loading the view.
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint:"wav")
            audioPlayer.enableRate = true
            audioPlayer.delegate = self
        } catch {
            print("Error occurred loading sound into AudioPlayer")
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        configureViewToStart()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureViewToStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playWithSpeed(speed: Float) {
        stopAndResetAudioEngine()
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()

    }
    
    @IBAction func playSlow(sender: UIButton) {
        configureViewToPlay()
        playWithSpeed(0.5)
    }

    @IBAction func playFast(sender: UIButton) {
        configureViewToPlay()
        playWithSpeed(2.0)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        configureViewToPlay()
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVader(sender: UIButton) {
        configureViewToPlay()
        playAudioWithVariablePitch(-1000)
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playAudioWithUnit(changePitchEffect)
        
    }
    
    func playAudioWithEcho(delay: Float) {
        let echoNode = AVAudioUnitDelay()
        echoNode.delayTime = NSTimeInterval(delay)
        playAudioWithUnit(echoNode)
    }
    
    func playAudioWithReverb(extent: Float) {
        let changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.wetDryMix = extent
        playAudioWithUnit(changeReverbEffect)
    }
    
    func playAudioWithUnit(effect: AVAudioUnit) {
        audioPlayer.stop()
        stopAndResetAudioEngine()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(effect)
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: configureViewToPlay)
        
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    @IBAction func playReverb(sender: UIButton) {
        configureViewToPlay()
        playAudioWithReverb(75.0)
    }
    
    @IBAction func playEcho(sender: UIButton) {
        configureViewToPlay()
        playAudioWithEcho(0.3)
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        configureViewToStart()
        audioPlayer.stop()
        stopAndResetAudioEngine()
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
