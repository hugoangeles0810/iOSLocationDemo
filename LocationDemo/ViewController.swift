//
//  ViewController.swift
//  LocationDemo
//
//  Created by Hugo Ángeles Chávez on 4/10/18.
//  Copyright © 2018 Hugo Ángeles Chávez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trackingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func handleTrackingClick(_ sender: Any) {
        if LocationService.sharedInstance.isActive {
            LocationService.sharedInstance.stopLocationUpdates()
            trackingBtn.setTitle("Start tracking", for: .normal)
        } else {
            LocationService.sharedInstance.startLocationUpdates()
            trackingBtn.setTitle("Stop tracking", for: .normal)
        }
    }
}

