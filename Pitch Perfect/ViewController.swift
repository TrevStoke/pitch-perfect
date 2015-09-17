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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordingLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: show text "recording in progress"
        //TODO: Record the user's voice
        recordingLabel.hidden = false
    }

}

