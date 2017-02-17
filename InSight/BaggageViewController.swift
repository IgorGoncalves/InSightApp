//
//  BaggageViewController.swift
//  Baggage
//
//  Created by Evan Stone on 9/19/16.
//  Copyright © 2016 Cloud City. All rights reserved.
//

import UIKit
import CoreLocation

class BaggageViewController: UIViewController, BeaconManagerDelegate, CLLocationManagerDelegate {
    
    
    //@IBOutlet weak var proximityLabel: UILabel!

    @IBOutlet weak var frenteLabel: UILabel!
    @IBOutlet weak var esquerdaLabel: UILabel!
    @IBOutlet weak var direitaLabel: UILabel!
    @IBOutlet weak var trasLabel: UILabel!
    
    @IBOutlet weak var direitaButton: UIButton!
    @IBOutlet weak var frenteButton: UIButton!
    @IBOutlet weak var esquerdaButton: UIButton!
    @IBOutlet weak var trasButton: UIButton!
    
    
    let suitcaseTopFar:CGFloat = 20.0
    var suitcaseTopNear:CGFloat!
    var suitcaseTopImmediate:CGFloat!
    
    let verticalCorrection:CGFloat = 64.0
    let velocity = 0.5
    
    var beaconManager:BeaconManager!
    var locationManager = CLLocationManager()
    let beacons = BeaconSevice.getBeacons()
    var beaconAtual:MyBeacon =  MyBeacon(minorId:0, locationName:"", position: "", locationVoice: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //proximityLabel.text = ""
    
        suitcaseTopNear = (view.frame.height / 3.0) - verticalCorrection
        suitcaseTopImmediate = (view.frame.height / 2.0) - verticalCorrection
        
        // Do any additional setup after loading the view.
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingHeading()
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
    
    
    @IBAction func esquerdaClick(_ sender: Any){
        if(self.beaconAtual.direction == "esquerda"){
            AudioService.Play(audio: self.beaconAtual.locationVoice[self.beaconAtual.direction]!)
            
        }
    }
    @IBAction func direitaClick(_ sender: Any) {
        if(self.beaconAtual.direction == "direita"){
            AudioService.Play(audio: self.beaconAtual.locationVoice[self.beaconAtual.direction]!)

        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        if(self.beaconAtual.direction == "frente"){
        AudioService.Play(audio: self.beaconAtual.locationVoice[self.beaconAtual.direction]!)
        }
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
  /*
        for beacon in beacons {
            if let bea: MyBeacon = BeaconSevice.getLocationByBeacon(minorId: beacon.minor.intValue) {
                proximityLabel.text = ""
                
                switch(beacon.proximity){
                case .unknown:
                    proximityLabel.text = "\(bea.locationName) unknown"
                case .far:
                    proximityLabel.text = "\(bea.locationName) far"
                
                case .near:
                    proximityLabel.text = " \(bea.locationName) near"
                    co = true
                case .immediate:
                    //proximityLabel.text = "immediate"
                 //
                        self.proximityLabel.text = bea.locationName
                        if let audio: [String: String] =  bea.locationVoice {
                            
                                AudioService.Play(audio: audio["esquerda"]!)
                                co = false
                            
                        }
                    
                    
                
                }
            //    print(beacon)
            }
        }
        return
*/
        
    }
    
    var co: Bool = false
    
    internal func beaconManager(_ manager: BeaconManager, didFindClosestBeacon beacon: CLBeacon) {
        
        //print("*** CLOSEST BEACON: \(beacon)")
        
        if (beacon.major.intValue != beaconManager.beaconMajor) || (beacon.minor.intValue != beaconManager.beaconMinor) {
            //proximityLabel.text = ""
            switch(beacon.proximity){
            case .unknown: break
             //   proximityLabel.text = "unknown"
            case .far:
              //  proximityLabel.text = "far"
                co = true
            case .near:
             //   proximityLabel.text = "near"
                
                if let bea: MyBeacon = BeaconSevice.getLocationByBeacon(minorId: beacon.minor.intValue) {
                    self.beaconAtual = bea
                    changeInterface(d:bea.direction,l: bea.locationName)
                    //   self.proximityLabel.text = bea.locationName
                    if let audio: [String: String] =  bea.locationVoice {
                        if(co){
                            AudioService.Play(audio: audio[bea.direction]!)
                            
                            
                            co = false
                        }
                    }
                }
            case .immediate: break
                //proximityLabel.text = "immediate"
                
                
            }
        //    print(beacon)
          //*/
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        print(newHeading.magneticHeading)
        //self.proximityLabel.text = String(format: "%.2f", newHeading.magneticHeading)
        for beacon in self.beacons {
            print ("dsads")
            positionToBeacon(beacon: beacon, posicaoTerra: newHeading.magneticHeading)
        }
        
    }

    func changeInterface(d: String, l:String){
        switch d {
        case "esquerda":
            esquerdaLabel.text = l
            direitaLabel.text = ""
            frenteLabel.text = ""
            trasLabel.text = ""
        case "direita":
            direitaLabel.text = l
            esquerdaLabel.text = ""
            frenteLabel.text = ""
            trasLabel.text = ""
        case "frente":
            frenteLabel.text = l
            direitaLabel.text = ""
            esquerdaLabel.text = ""
            trasLabel.text = ""
        default:
            print("ferrou")
            //posicao = posicaoTerra
        }
    
    }
    func positionToBeacon(beacon: MyBeacon, posicaoTerra: Double) {
        
        var posicao:Double
        switch beacon.position.lowercased() {
        case "norte":
            posicao = posicaoTerra
        case "leste":
            posicao =  (posicaoTerra + 90)
        case "sul":
            posicao = (posicaoTerra + 180)
        case "oeste":
            posicao = (posicaoTerra + 270)
        default:
            print("norte")
            posicao = posicaoTerra
        }
        
        // Indica posição relativa à posição do iBeacon
        if posicao > 360 {
            posicao = posicao - 360
        }
        switch posicao {
        case 330.1...359.9, 0...30:
      //      frenteButton.alpha = 1
            print("\(beacon.locationName) De Frente pro \(beacon.position) - id \(beacon.minorId)")
            beacon.direction =  "frente"
        case 30.1...150:
        //    esquerdaButton.alpha = 1
            print("O \(beacon.locationName) está a sua Esquerda ")
            beacon.direction =  "esquerda"
        case 151.6...210:
          //  trasButton.alpha = 1
            print("O \(beacon.locationName) está Atrás")
            //beacon.direction =  "atras"
        case 210.1...330:
            //direitaButton.alpha = 1
            print("O \(beacon.locationName) está a sua Direita ")
            beacon.direction =  "direita"
        default:
            print("Perdido")
            //beacon.direction =  "perdido"
        }
    }
    

    
}



