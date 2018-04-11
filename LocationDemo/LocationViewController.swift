//
//  ViewController.swift
//  LocationDemo
//
//  Created by Hugo Ángeles Chávez on 4/10/18.
//  Copyright © 2018 Hugo Ángeles Chávez. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {

    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var trackingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func handleTrackingClick(_ sender: Any) {
        if LocationService.sharedInstance.isActive {
            LocationService.sharedInstance.stopLocationUpdates()
            trackingBtn.setTitle("Start tracking", for: .normal)
            locationLbl.text = "Posición desconocida 🤷‍♂️"
        } else {
            LocationService.sharedInstance.startLocationUpdates()
            LocationService.sharedInstance.delegate = self
            trackingBtn.setTitle("Stop tracking", for: .normal)
        }
    }
}

extension LocationViewController : LocationServiceDelegate {
    
    func locationService(_ locationService: LocationService, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationLbl.text = "Lat: \(location.coordinate.latitude), Lng: \(location.coordinate.longitude)"
        }
    }
    
    
}

