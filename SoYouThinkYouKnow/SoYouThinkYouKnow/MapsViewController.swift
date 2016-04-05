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
    
        //@IBOutlet weak var placeTheyChose: UILabel!
        @IBOutlet weak var nextButton: UIButton!
    
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
        
            //put regular map on based on user choice
            let styleURL = NSURL(string: "mapbox://styles/cvagrad86/cihlqsphk000gb4kqezw4sjbd")
            mapView = MGLMapView(frame: view.bounds, styleURL: styleURL)
            mapView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            view.addSubview(mapView!)
            
            let doubleTap = UITapGestureRecognizer(target: self, action: nil)
            doubleTap.numberOfTapsRequired = 2
            mapView!.addGestureRecognizer(doubleTap)
 
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(MapsViewController.handleSingleTap(_:)))
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
        distanceBetweenSpots.hidden = true
        mapView!.removeAnnotations(mapView!.annotations!)
        
            }
    
    func nextQuestion() -> Place {
        let thisLocation = CLLocation()
        var currentQuestion:Place = Place(name: "", location: thisLocation, hint: "")
        if questionIdx < place.count  {
            currentQuestion =  place[questionIdx]
            spotToLocate.text = currentQuestion.hint
            placeToLocate = currentQuestion.location
            
        } else {
            showAlert()
        }
        
    return currentQuestion
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
            let correctPlace = nextQuestion().name
            
            distanceBetweenSpots.hidden = false
            self.distanceBetweenSpots.text = ("Correct Answer is \(correctPlace). You were (\(distance.formatWithDecimalPlaces(1))) miles away")
            
            nextButton.hidden = false
            
            nextButton.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            UIView.animateWithDuration(2.0,
                                       delay: 0,
                                       usingSpringWithDamping: 0.70,
                                       initialSpringVelocity: 10.00,
                                       options: UIViewAnimationOptions.AllowUserInteraction,
                                       animations: {
                                        self.nextButton.transform = CGAffineTransformIdentity
                }, completion: nil)

           
            //placeTheyChose.text = nextQuestion().name
            
            score = (score + thisTry.formatWithDecimalPlaces(1))
            
            self.placeChosen.text = ("Your Score: \(score)")
            
            questionIdx += 1
            
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

