//
//  LocationService.swift
//  Baggage
//
//  Created by Student on 14/02/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit
import Foundation

class BeaconSevice {
    
    private static let beacons:[MyBeacon] = [
        MyBeacon(minorId: 42295,
                   locationName: "Banheiro",
                   position: "Leste",
                   locationVoice: ["esquerda": "banheiro_esquerda", "direita": "banheiro_direita", "frente": "banheiro_frente"]),
        MyBeacon(minorId: 5953,
                   locationName: "Escada",
                   position: "Oeste",
                   locationVoice: ["esquerda": "escada_2_dcomp_esquerda", "direita": "escada_2_dcomp_direita", "frente": "escada_2_dcomp_frente"]),
        MyBeacon(minorId: 34186,
                   locationName: "Secretaria",
                   position: "Norte",
                   locationVoice: ["esquerda": "secretaria_dcomp_esquerda", "direita": "secretaria_dcomp_direita", "frente": "secretaria_dcomp_frente"]),
    ]
    
    private static let backgroundColors: [Int : UIColor] = [
        34186: UIColor(red: 109/255.0, green: 170/255.0, blue: 199/255.0, alpha: 1.0),
        42295: UIColor(red: 109/255.0, green: 170/255.0, blue: 199/255.0, alpha: 1.0),
        3272:   UIColor(red:  36/255.0, green:  24/255.0, blue:  93/255.0, alpha: 1.0),
        5953:   UIColor(red: 155/255.0, green: 186/255.0, blue: 160/255.0, alpha: 1.0),
        59435:   UIColor(red: 155/255.0, green: 186/255.0, blue: 160/255.0, alpha: 1.0),
        ]
    
    static func getLocationByBeacon(minorId: Int) -> MyBeacon? {
        return self.beacons.first(where: { (val) -> Bool in
            return val.minorId == minorId
        })
    }
    
}
