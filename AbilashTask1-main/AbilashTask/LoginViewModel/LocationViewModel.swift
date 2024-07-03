//
//  temp.swift
//  BibleReadingApp (iOS)
//
//  Created by Ganesh on 15/11/22.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit


struct Place: Identifiable {
    let id = UUID()
    let name: String
    var coordinate: CLLocationCoordinate2D
    let Description : String
    let eventid : String
}

class WrappableMapView: MKMapView, MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = getRandomColor()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func getRandomColor() -> UIColor{
         let randomRed = CGFloat.random(in: 0...1)
         let randomGreen = CGFloat.random(in: 0...1)
         let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

struct SingleLocationView: UIViewRepresentable {
    func makeUIView(context: Context) -> WrappableMapView {
        mapView.delegate = mapView
        return mapView
    }
    
    func updateUIView(_ uiView: WrappableMapView, context: Context) {
        
        let requestAnnotation = MKPointAnnotation()
        requestAnnotation.coordinate = requestLocation
        requestAnnotation.title = DestinationName
        uiView.addAnnotation(requestAnnotation)
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = requestLocation2
        destinationAnnotation.title = ""
        uiView.addAnnotation(destinationAnnotation)
        
        let requestPlacemark = MKPlacemark(coordinate: requestLocation)
        let requestPlacemark1 = MKPlacemark(coordinate: requestLocation2)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: requestPlacemark)
        directionRequest.destination = MKMapItem(placemark: requestPlacemark1)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let response = response else { return }
            let route = response.routes[0]
            uiView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            uiView.setVisibleMapRect(rect, edgePadding: .init(top: 10.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
        }
    }
    
    
    
    @Binding var requestLocation: CLLocationCoordinate2D
    @Binding var requestLocation2: CLLocationCoordinate2D
    var DestinationName : String
    private let mapView = WrappableMapView()
   
}



class WrappableMapView1: MKMapView, MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = getRandomColor()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func getRandomColor() -> UIColor{
         let randomRed = CGFloat.random(in: 0...1)
         let randomGreen = CGFloat.random(in: 0...1)
         let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

struct MultipleLocationView: UIViewRepresentable {
    func makeUIView(context: Context) -> WrappableMapView1 {
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]

        mapView.delegate = mapView
        mapView.showsUserLocation = true
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CurentLocation.coordinate.latitude, longitude: CurentLocation.coordinate.longitude), latitudinalMeters: 20000.0, longitudinalMeters: 20000.0), animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: WrappableMapView1, context: Context) {
    
        for x in LocationsArr{
            let requestAnnotation = MKPointAnnotation()
            requestAnnotation.coordinate = x.coordinate
            requestAnnotation.title = x.name
            uiView.addAnnotation(requestAnnotation)
        }
    }
    
    @Binding var LocationsArr: [St_Loaction]
    @State var CurentLocation : CLLocation
    private let mapView = WrappableMapView1()
   
}
struct St_Loaction: Identifiable {
    let id = UUID()
    let name: String
    var coordinate: CLLocationCoordinate2D
}
