//
//  BaggageViewController.swift
//  Baggage
//
//  Created by Evan Stone on 9/19/16.
//  Copyright © 2016 Cloud City. All rights reserved.
//

import UIKit
import CoreLocation

class BaggageViewController: UIViewController, BeaconManagerDelegate {
    
    
    @IBOutlet weak var proximityLabel: UILabel!

    
    let suitcaseTopFar:CGFloat = 20.0
    var suitcaseTopNear:CGFloat!
    var suitcaseTopImmediate:CGFloat!
    
    let verticalCorrection:CGFloat = 64.0
    let velocity = 0.5
    
    var beaconManager:BeaconManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proximityLabel.text = ""
    
        suitcaseTopNear = (view.frame.height / 3.0) - verticalCorrection
        suitcaseTopImmediate = (view.frame.height / 2.0) - verticalCorrection
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        beaconManager = BeaconManager()
        beaconManager.delegate = self
        beaconManager.initializeLocationManager()
        beaconManager.authorizeLocationServices()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    // MARK: - BeaconManagerDelegate methods
    
    internal func beaconManager(_ manager: BeaconManager, locationServicesAuthorized: Bool, status:CLAuthorizationStatus) {
        let auth = locationServicesAuthorized ? "YES" : "NO"
        print("*** beaconManager:locationServicesAuthorized: \(auth)")
        
        if locationServicesAuthorized {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                self.beaconManager.startRanging()
            }
        } else {
            if status == CLAuthorizationStatus.denied {
                print("****** SHOWING SCANNING DISABLED ALERT!!!")
                let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: { () -> Void in
                    let alertController = UIAlertController(
                        title: "Scanning Disabled",
                        message: "To enable scanning of items in the kit, you will need to enable Location Services in your iPad's iOS Settings:\n\n" +
                            "Settings -> Privacy -> Location Services -> Baggage\n\n" +
                        "Switch the \"ALLOW LOCATION ACCESS\" to \"While Using the App.\"",
                        preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                        //
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: { () -> Void in
                        //
                    })
                })
            }
        }
    }
    
    internal func beaconManager(_ manager: BeaconManager, didFindBeacons beacons: Array<CLBeacon>, inRegion region: CLBeaconRegion) {
        //print("*** BEACONS FOUND: \(beacons)")
    }
    
    var co: Bool = false
    
    internal func beaconManager(_ manager: BeaconManager, didFindClosestBeacon beacon: CLBeacon) {
        
        //print("*** CLOSEST BEACON: \(beacon)")
        
        if (beacon.major.intValue != beaconManager.beaconMajor) || (beacon.minor.intValue != beaconManager.beaconMinor) {
            proximityLabel.text = ""
            switch(beacon.proximity){
            case .unknown:
                proximityLabel.text = "unknown"
            case .far:
                proximityLabel.text = "far"
                
            case .near:
                proximityLabel.text = "near"
                co = true
            case .immediate:
                //proximityLabel.text = "immediate"
                if let bea: MyBeacon = BeaconSevice.getLocationByBeacon(minorId: beacon.minor.intValue) {
                    self.proximityLabel.text = bea.locationName
                    if let audio: [String: String] =  bea.locationVoice {
                        if(co){
                            AudioService.Play(audio: audio["esquerda"]!)
                            co = false
                        }
                    }
                    
                }
                
            }
            print(beacon)
            
            return
        }

        
    }
    
    
}
