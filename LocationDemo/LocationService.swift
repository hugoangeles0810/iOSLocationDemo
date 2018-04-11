//
//  LocationService.swift
//  LocationDemo
//
//  Created by Hugo Ángeles Chávez on 4/10/18.
//  Copyright © 2018 Hugo Ángeles Chávez. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationServiceDelegate : NSObjectProtocol {
    
    func locationService(_ locationService: LocationService, didUpdateLocations locations: [CLLocation] )
    
}

class LocationService : NSObject, CLLocationManagerDelegate {
    
    public static let sharedInstance = LocationService()
    private static let distanceFilterInMeters: CLLocationDistance = 10
    
    weak var delegate: LocationServiceDelegate?
    
    public var isActive: Bool {
            return _isServiceActive
    }
    
    private var _isServiceActive = false
    
    private lazy var locationManager: CLLocationManager = {
       return CLLocationManager()
    }()
    
    public func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = LocationService.distanceFilterInMeters
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            _isServiceActive = true
        }
    }
    
    public func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        _isServiceActive = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationService(self, didUpdateLocations: locations)
        NotificationCenter.default.post(name: .location, object: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

extension NSNotification.Name {
    static let location = Notification.Name(rawValue: "NotificationLocation")
}
