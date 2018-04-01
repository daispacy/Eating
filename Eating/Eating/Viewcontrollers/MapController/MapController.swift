//
//  MapController.swift
//  Promised Land
//
//  Created by Dai Pham on 3/20/18.
//  Copyright © 2018 Dai Pham. All rights reserved.
//

import UIKit
import MapKit

enum MapControllerType {
    case lite
    case full
}

protocol MapControllerDelegate:class {
    func mapControllerWillDismiss(vc:MapController)
}

class MapController: BaseController {
    
    // MARK: - api
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        
    }
    
    func tapAction(_ gestureReconizer:UITapGestureRecognizer) {
        let location = gestureReconizer.location(in:mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        // Add annotation:
        MonitorLocation.shared.getPlaceMark(from: coordinate) { [weak self] placemark in
            guard let _self = self else {return}
            if let placeMark = placemark {
                _self.dropPinZoomIn(placemark: MKPlacemark(placemark: placeMark))
            }
        }
    }
    
    func getDirections(_ sender:UIButton) {
        if let selectedPin = selectedPin {
            
            let request = MKDirectionsRequest()
            request.source = MKMapItem.forCurrentLocation()
            let mapItem = MKMapItem(placemark: selectedPin)
            request.destination = mapItem
            request.transportType = MKDirectionsTransportType.any
            request.requestsAlternateRoutes = true
            let directions = MKDirections(request: request)
            
            directions.calculate(completionHandler: {[weak self] (response, err) in
                guard let _self = self else {return}
                guard let response = response else {
                    //handle the error here
                    return
                }
                
                _self.currentRoutes = response.routes
                for (_,route) in response.routes.enumerated() {
                    _self.mapView.add(route.polyline)
                    
                }
            })
        }
    }
    
    func showQuestionButton(_ sender:NSNotification) {
        btnDirection.isHidden = false
    }
    
    // MARK: - private
    fileprivate func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        
        // clear existing pins & overlays
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    private func config() {
        
        mapView.delegate = self

        btnDirection.isHidden = true
        btnDirection.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        
        mapView.showsUserLocation = true
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        
        vwInformationRestaurant.isHidden = type == .lite
        
        
    }
    
    fileprivate func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        MonitorLocation.shared.getCoordinateFromAddress(address: "65/30A Giải phóng, Phường 2, Tân Bình, Hồ Chí Minh") {[weak self] (coordinate, placemark) in
            guard let _self = self else {return}
            if let pmark = placemark {
                _self.dropPinZoomIn(placemark: MKPlacemark(placemark: pmark))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if type == .full {
            self.view.frame = UIScreen.main.bounds
            self.view.setNeedsDisplay()
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if let p = parent {
            type = p.isKind(of: ContainerMapController.self) ? .full : .lite
            mapView.isScrollEnabled = p.isKind(of: ContainerMapController.self)
        }
        if type == .full {
            if gestureRecognizer == nil {
                gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                mapView.addGestureRecognizer(gestureRecognizer)
            }
        } else {
            if gestureRecognizer != nil {
                mapView.removeGestureRecognizer(gestureRecognizer)
            }
        }
        if vwInformationRestaurant != nil {
            vwInformationRestaurant.isHidden = type == .lite
        }
    }
    
    deinit {
        if gestureRecognizer != nil {
            mapView.removeGestureRecognizer(gestureRecognizer)
        }
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var selectedPin:MKPlacemark? = nil
    var currentRoutes:[MKRoute] = []
    var matchingItems:[MKMapItem] = []
    weak var delegate:MapControllerDelegate?
    var type:MapControllerType = .full
    var gestureRecognizer:UITapGestureRecognizer!
    
    // MARK: - outlet
    @IBOutlet weak var vwNameRestaurantView: BlockNameRestaurantView!
    @IBOutlet weak var lblOpenHours: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet weak var vwInformationRestaurant: UIView!
}

// MARK: -
extension MapController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation.isKind(of:MKUserLocation.self) {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        var pinView: MKAnnotationView
        let reuseId = "pin"
        if let dequepinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) {
            dequepinView.annotation = annotation
            pinView = dequepinView
        } else {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView.canShowCallout = true
        }
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(#imageLiteral(resourceName: "star").resizeImageWith(newSize: CGSize(width: 20, height: 20)), for: .normal)
        button.addTarget(self, action: #selector(getDirections(_:)), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        pinView.image = #imageLiteral(resourceName: "star").resizeImageWith(newSize: CGSize(width: 20, height: 20)).tint(with: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if let first = view.annotation, let selectedPin = self.selectedPin {
                if first.coordinate.latitude == selectedPin.coordinate.latitude && first.coordinate.longitude == selectedPin.coordinate.longitude {
                    mapView.selectAnnotation(first, animated: false)
                    break
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        for (i,route) in currentRoutes.enumerated() {
            let myLineRenderer = MKPolylineRenderer(polyline: route.polyline)
            if i == 0 {
                myLineRenderer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).withAlphaComponent(0.7) as UIColor
            } else {
                myLineRenderer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.3) as UIColor
            }
            myLineRenderer.lineWidth = 5
            return myLineRenderer
        }
        return MKPolylineRenderer()
    }
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        let span = MKCoordinateSpanMake(0.01, 0.01)
//        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
//        mapView.setRegion(region, animated: true)
//    }
}
