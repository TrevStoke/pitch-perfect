//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Trevor Adams on 17/09/2015.
//  Copyright © 2015 Trevor Adams. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
        
    init(withFilePathUrl filePathUrl: NSURL) {
        self.filePathUrl = filePathUrl
        self.title = filePathUrl.lastPathComponent
    }
    
    init(withFilePathUrl filePathUrl: NSURL, withTitle title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}