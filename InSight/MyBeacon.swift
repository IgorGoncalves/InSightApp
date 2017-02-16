//
//  beacon.swift
//  Baggage
//
//  Created by Student on 14/02/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import Foundation

class MyBeacon {
    let locationName: String
    let minorId: Int
    let position: String
    let locationVoice: [String: String]!
    var direction: String
    
    init(minorId: Int, locationName: String, position: String, locationVoice: [String: String]!){
        self.locationName = locationName
        self.position = position
        self.minorId = minorId
        self.locationVoice = locationVoice
        self.direction = ""
    }
    
}

