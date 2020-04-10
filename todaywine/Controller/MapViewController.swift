//
//  MapViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/03/30.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewControllerBase, CLLocationManagerDelegate {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    var shopAddressLatitude: CLLocationDegrees = 0.0
    var shopAddressLongitude: CLLocationDegrees = 0.0
    
    private let initialLocation = CLLocation(latitude: 37.3794212, longitude: 127.1120506)
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 1
        let location = CLLocationCoordinate2D(latitude: shopAddressLatitude,
                                              longitude: shopAddressLongitude)
        
        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        // 3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "고리와인샵"
        annotation.subtitle = "BKTrading"
        mapView.addAnnotation(annotation)
    }
    
}
