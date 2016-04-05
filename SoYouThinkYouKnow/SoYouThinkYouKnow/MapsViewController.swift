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
import CoreLocation

class MapsViewController: UIViewController, MGLMapViewDelegate  {
        
        var mapView: MGLMapView?
    
    @IBOutlet weak var nextButton: UIButton!
    
        //this has to come from the array
        var placeToLocate = CLLocation(latitude: 43.661471, longitude: -70.255326)
    
    
        var locationManager = CLLocationManager()
        var placeSelected:String?
    
    var placeslist = [Place]()
    var answers = [String]()
    var questionIdx = 0
    var question: String?
    var score = 0.00
    
        @IBOutlet weak var placeChosen: UILabel!
        @IBOutlet weak var spotToLocate: UILabel!
        @IBOutlet weak var distanceBetweenSpots: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            nextButton.hidden = true
            nextQuestion()
            let styleURL = NSURL(string: "mapbox://styles/cvagrad86/cihlqsphk000gb4kqezw4sjbd")
            mapView = MGLMapView(frame: view.bounds, styleURL: styleURL)
            mapView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            view.addSubview(mapView!)
            
            let doubleTap = UITapGestureRecognizer(target: self, action: nil)
            doubleTap.numberOfTapsRequired = 2
            mapView!.addGestureRecognizer(doubleTap)
 
            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
            singleTap.requireGestureRecognizerToFail(doubleTap)
            mapView!.addGestureRecognizer(singleTap)
        
            
            var centerScreenPoint = mapView!.setCenterCoordinate(CLLocationCoordinate2D(latitude: 45.3235,
                longitude: -69.1653), zoomLevel: 6, animated: false)

            let addSpot = UILongPressGestureRecognizer(target: self, action: "action:")
            addSpot.minimumPressDuration = 1
            mapView!.addGestureRecognizer(addSpot)
            mapView!.delegate = self
            
            self.view.addSubview(placeChosen)
            self.view.addSubview(spotToLocate)
            self.view.addSubview(distanceBetweenSpots)
            self.view.addSubview(nextButton)
        }
    
    @IBAction func nextMap(sender: AnyObject) {
        nextQuestion()
        nextButton.hidden = true
        questionIdx += 1
        mapView!.removeAnnotations(mapView!.annotations!)
    }
    
    func nextQuestion() -> Place {
        // initialize current question
        let thisLocation = CLLocation()
        var currentQuestion:Place = Place(name: "", location: thisLocation, hint: "")

        if questionIdx < place.count  {
            currentQuestion =  place[questionIdx]
            spotToLocate.text = currentQuestion.hint
            placeToLocate = currentQuestion.location
        } else {
            showAlert()
        }
        //titlesForButtons()
        
    return currentQuestion
    }
    
    func titlesForButtons() {
        for questionIdx in place.enumerate() {
            //spotToLocate.text = nextQuestion().hint
            //placeToLocate = nextQuestion().location
        }
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
            let location: CLLocationCoordinate2D = mapView!.convertPoint(tap.locationInView(mapView), toCoordinateFromView: mapView)
            
            // create an array of coordinates for our polyline
            var coordinates: [CLLocationCoordinate2D] = [location, placeToLocate.coordinate]
            
            
            // remove existing polyline from the map, (re)add polyline with coordinates
            if (mapView!.annotations?.count != nil) {
                mapView!.removeAnnotations(mapView!.annotations!)
            }
            let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
            mapView!.addAnnotation(polyline)
            
            let meters:CLLocationDistance = placeToLocate.distanceFromLocation(CLLocation(latitude: location.latitude, longitude: location.longitude))
            
            let distance = (meters.formatWithDecimalPlaces(2) * 0.0006214)
            
            let thisTry = distance
            
            self.distanceBetweenSpots.text = ("You were (\(distance.formatWithDecimalPlaces(1))) miles away")
            
            nextButton.hidden = false
            
            score = (score + thisTry.formatWithDecimalPlaces(1))
            
            self.placeChosen.text = ("Your Score: \(score)")
            
                //("Your score: \(distance.formatWithDecimalPlaces(1) * 5)")
            
            //attempts to get score
            
        }
    
    
    func showAlert() {
        //var vc: UIViewController?
        let alertController = UIAlertController(title: "That's all the Maps!", message: "Time to tally your final score", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ayuh", style: .Default, handler: { (alert: UIAlertAction!) in
            
            self.performSegueWithIdentifier("ScoreSegue", sender: self)
            //vc = self.storyboard?.instantiateViewControllerWithIdentifier("scoreViewController") as! ScoreViewController
        })
        
        alertController.addAction(ok)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
        func action(gestureRecognizer:UIGestureRecognizer){
            if gestureRecognizer.state == UIGestureRecognizerState.Began {
                let touchPoint = gestureRecognizer.locationInView(mapView)
                let newCoordinate: CLLocationCoordinate2D = mapView!.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
                self.placeChosen.text = ("You tapped at: \(newCoordinate.latitude), \(newCoordinate.longitude)")
                
            }
        }
        
        
        
    }



    extension Double {
        func formatWithDecimalPlaces(decimalPlaces: Int) -> Double {
            let formattedString = NSString(format: "%.\(decimalPlaces)f", self) as String
            return Double(formattedString)!
        }
    }

