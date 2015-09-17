//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Trevor Adams on 16/09/2015.
//  Copyright (c) 2015 Trevor Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.hidden = false
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        //TODO: Record the user's voice
    }

    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
    }
}

