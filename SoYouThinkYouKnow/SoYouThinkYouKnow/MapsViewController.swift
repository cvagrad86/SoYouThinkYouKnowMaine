//
//  MapsViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//
import UIKit
import UIKit
import Mapbox
import MapKit

class MapsViewController: UIViewController, MGLMapViewDelegate  {
        
        var mapView: MGLMapView!
        var placeToLocate = CLLocation(latitude: 43.661471, longitude: -70.255326)
        var locationManager = CLLocationManager()
        var searchController:UISearchController!
        var annotation:MGLAnnotation!
        var localSearchRequest:MKLocalSearchRequest!
        var localSearch:MKLocalSearch!
        var localSearchResponse:MKLocalSearchResponse!
        var error:NSError!
        var pointAnnotation:MGLPointAnnotation!
        //var pinAnnotationView:
        var mapItemData:MKMapItem!
        
        var placeSelected:String?
        
        @IBOutlet weak var placeChosen: UILabel!
        @IBOutlet weak var spotToLocate: UILabel!
        @IBOutlet weak var distanceBetweenSpots: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mapView = MGLMapView(frame: view.bounds)
            mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            view.addSubview(mapView)
            
            // double tapping zooms the map, so ensure that can still happen
            let doubleTap = UITapGestureRecognizer(target: self, action: nil)
            doubleTap.numberOfTapsRequired = 2
            mapView.addGestureRecognizer(doubleTap)
            
            // delay single tap recognition until it is clearly not a double
            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
            singleTap.requireGestureRecognizerToFail(doubleTap)
            mapView.addGestureRecognizer(singleTap)
            
            // convert `mapView.centerCoordinate` (CLLocationCoordinate2D)
            // to screen location (CGPoint)
            //let centerScreenPoint: CGPoint = mapView.convertCoordinate(mapView.centerCoordinate, toPointToView: mapView)
            
            var centerScreenPoint = mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 45.3235,
                longitude: -69.1653),
                                                                zoomLevel: 6, animated: false)
            print("Screen center: \(centerScreenPoint) = \(mapView.center)")
            
            let addSpot = UILongPressGestureRecognizer(target: self, action: "action:")
            addSpot.minimumPressDuration = 1
            mapView.addGestureRecognizer(addSpot)
            mapView.delegate = self
            
            self.view.addSubview(placeChosen)
            self.view.addSubview(spotToLocate)
            self.view.addSubview(distanceBetweenSpots)
            spotToLocate.text = "Click on Maine's largest city"
            
        }
        
        func distanceCalculated () {
            let userLocation:CLLocation = CLLocation(latitude: 44.310624, longitude: -69.779490)
            let priceLocation:CLLocation = CLLocation(latitude: 43.661471, longitude: -70.255326)
            let meters:CLLocationDistance = userLocation.distanceFromLocation(priceLocation)
            print("\(meters)")
        }
        
        func handleSingleTap(tap: UITapGestureRecognizer) {
            // convert tap location (CGPoint)
            // to geographic coordinates (CLLocationCoordinate2D)
            let location: CLLocationCoordinate2D = mapView.convertPoint(tap.locationInView(mapView), toCoordinateFromView: mapView)
            print("You tapped at: \(location.latitude), \(location.longitude)")
            
            
            // create an array of coordinates for our polyline
            var coordinates: [CLLocationCoordinate2D] = [location, placeToLocate.coordinate]
            
            
            // remove existing polyline from the map, (re)add polyline with coordinates
            if (mapView.annotations?.count != nil) {
                mapView.removeAnnotations(mapView.annotations!)
            }
            let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
            mapView.addAnnotation(polyline)
            
            let meters:CLLocationDistance = placeToLocate.distanceFromLocation(CLLocation(latitude: location.latitude, longitude: location.longitude))
            let distance = (meters.formatWithDecimalPlaces(2) * 0.0006214)
            
            self.distanceBetweenSpots.text = ("You were (\(distance.formatWithDecimalPlaces(1))) miles away")
            
            print("\(distance)")
            
            self.placeChosen.text = ("Your score: \(distance.formatWithDecimalPlaces(1) * 5)")
            
        }
        
        func action(gestureRecognizer:UIGestureRecognizer){
            if gestureRecognizer.state == UIGestureRecognizerState.Began {
                let touchPoint = gestureRecognizer.locationInView(mapView)
                let newCoordinate: CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
                self.pointAnnotation = MGLPointAnnotation()
                pointAnnotation.coordinate = newCoordinate
                pointAnnotation.title = "New Place Added"
                pointAnnotation.subtitle = "click i to add details"
                let pinAnnotationView = MGLPointAnnotation()
                self.mapView.addAnnotation(pointAnnotation)
                self.placeChosen.text = ("You tapped at: \(newCoordinate.latitude), \(newCoordinate.longitude)")
                print(pointAnnotation.coordinate)
                
            }
        }
        
        
        
    }
    
    extension Double {
        func formatWithDecimalPlaces(decimalPlaces: Int) -> Double {
            let formattedString = NSString(format: "%.\(decimalPlaces)f", self) as String
            return Double(formattedString)!
        }
    }

