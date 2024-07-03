//
//  LocationManager.swift
//  AbilashTask
//
//  Created by MacBk on 01/07/24.
//

import Foundation
import CoreLocation
import CoreLocationUI
class LocationManager: NSObject,ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var location :CLLocation? = nil
    @Published var Authoriztaion : CLAuthorizationStatus = .notDetermined
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        Authoriztaion = locationManager.authorizationStatus
    }
    
    func Req(){
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
    }
        
    func GetLocation(){
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
    }
        
}
extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            Req()
            Authoriztaion = .authorizedAlways
        }else if status == .authorizedWhenInUse{
            Req()
            Authoriztaion = .authorizedWhenInUse
        }else if status == .denied{
            Authoriztaion = .denied
        }else if status == .notDetermined{
            Authoriztaion = .notDetermined
        }else if status == .restricted{
            Authoriztaion = .restricted
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "location"), object: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
    
}
