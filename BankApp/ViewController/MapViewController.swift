//
//  MapViewController.swift
//  BankApp
//
//  Created by Hai Le Thanh on 12/1/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: BaseViewController {
    var atmLocation: ATMLocation?
    var transaction: TransactionViewModel?
    
    @IBOutlet private weak var mapView: MKMapView!
    
    override func navigationTitle() -> String {
        return "ATM Location"
    }
    
    override func shouldHideNavigationBar() -> Bool {
        return false
    }
    
    override func configureContent() {
        super.configureContent()
        if let location = atmLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.location
            mapView.addAnnotation(annotation)
            
            // Set region
            let region = MKCoordinateRegionMake(location.location, MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "atmAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.image = UIImage(named: "CBAFindUsAnnotationIconATM")
        annotationView?.annotation = annotation
        return annotationView
    }
}
