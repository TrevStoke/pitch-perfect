//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Trevor Adams on 16/09/2015.
//  Copyright (c) 2015 Trevor Adams. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recorded:RecordedAudio!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureViewToStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordAudio(sender: UIButton) {
        configureViewToRecording()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recording.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if(flag){
            recorded = RecordedAudio(withFilePathUrl: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recorded)
        } else {
            configureViewToStart()
        }
    }
    
    @IBAction func pauseRecord(sender: UIButton) {
        if(audioRecorder.recording) {
            audioRecorder.pause()
            setPauseButtonImage("play")
        } else {
            setPauseButtonImage("pause")
            audioRecorder.record()
        }
    }
    
    func configureViewToStart() {
        recordingLabel.hidden = false
        recordingLabel.text = "Tap to Record"
        stopButton.hidden = true
        pauseButton.hidden = true
        setPauseButtonImage("pause")
    }
    
    func configureViewToRecording() {
        recordButton.enabled = false
        recordingLabel.hidden = false
        recordingLabel.text = "Recording in Progress"
        stopButton.hidden = false
        stopButton.enabled = true
        pauseButton.hidden = false
        setPauseButtonImage("pause")
    }
    
    func setPauseButtonImage(name: String) {
        pauseButton.setImage(UIImage(named: name), forState: UIControlState.Normal)
    }
}

