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
import AVKit
import AVFoundation
import GoogleMobileAds


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
        var score = 1000.00
        var audioPlayer: AVAudioPlayer?
        var bonus = 0
        var queuePlayer = AVQueuePlayer()
   
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var bonusCoin: UIImageView!
        @IBOutlet weak var placeChosen: UILabel!
        @IBOutlet weak var spotToLocate: UILabel!
        @IBOutlet weak var distanceBetweenSpots: UILabel!
    
    
    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            nextButton.hidden = true
            nextQuestion()
            bonusCoin.hidden = true
            
            
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
                longitude: -69.1653), zoomLevel: 5.8, animated: false)

            let addSpot = UILongPressGestureRecognizer(target: self, action: "action:")
            addSpot.minimumPressDuration = 1
            mapView!.addGestureRecognizer(addSpot)
            mapView!.delegate = self
            
            self.view.addSubview(placeChosen)
            self.view.addSubview(spotToLocate)
            self.view.addSubview(distanceBetweenSpots)
            self.view.addSubview(nextButton)
            
            
            bannerView.adUnitID = "ca-app-pub-2234370748694357/4389721028"
            bannerView.rootViewController = self
            bannerView.loadRequest(GADRequest())
        }
    
    @IBAction func nextMap(sender: AnyObject) {
        nextQuestion()
        nextButton.hidden = true
        distanceBetweenSpots.hidden = true
        mapView!.removeAnnotations(mapView!.annotations!)
        bonusCoin.hidden = true
        
            }
    
    func bonusPoints () {
       
        bonus += 1
        
        Scoring.sharedGameData.bonusPoints = bonus
        
       self.view.addSubview(bonusCoin)
        self.bonusCoin.hidden = false
        
        
        bonusAudio ()
       UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 4, initialSpringVelocity: 4, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.bonusCoin.transform = CGAffineTransformMakeScale(1.5 , 1.5)
        
            }, completion: nil)
        
         NSNotificationCenter.defaultCenter().postNotificationName("bonusPointAdded", object: self)

    }
    
    func bonusAudio () {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bonus_sound1", ofType: "mp3")!))
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    func createPlayerItem(item: String, ofType type: String) {
        let path = NSBundle.mainBundle().pathForResource(item, ofType: type)
        let url = NSURL.fileURLWithPath(path!)
        let item = AVPlayerItem(URL: url)
        queuePlayer.insertItem(item, afterItem: nil)
        
    }

    
    
    func nextQuestion() -> Place {
        let thisLocation = CLLocation()
        var currentQuestion:Place = Place(name: "", location: thisLocation, hint: "", audio: "")
        if questionIdx < place.count  {
            currentQuestion =  place[questionIdx]
            spotToLocate.text = currentQuestion.hint
            placeToLocate = currentQuestion.location
            createPlayerItem(currentQuestion.audio, ofType: "aiff")
            queuePlayer.play()
        } else {
            showAlert()
            endAudio()
        }
        
        
    return currentQuestion
    }
    
    
    func tapAudio () {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("map_tap2", ofType: "aiff")!))
            
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
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
            tapAudio()
            let meters:CLLocationDistance = placeToLocate.distanceFromLocation(CLLocation(latitude: location.latitude, longitude: location.longitude))
            
            let distance = (meters.formatWithDecimalPlaces(2) * 0.0006214)
            
            let thisTry = distance
            let correctPlace = nextQuestion().name
            
            distanceBetweenSpots.hidden = false
            self.distanceBetweenSpots.text = ("Correct Answer is \(correctPlace). You were (\(distance.formatWithDecimalPlaces(1))) miles away")
            if distance < 5.0 {
                bonusCoin.hidden = false
                bonusPoints()
            }
            nextButton.hidden = false
        
            queuePlayer.advanceToNextItem()
            
            nextButton.transform = CGAffineTransformMakeScale(2.0, 2.0)
            
            UIView.animateWithDuration(2.0,
                                       delay: 0,
                                       usingSpringWithDamping: 5.70,
                                       initialSpringVelocity: 10.00,
                                       options: UIViewAnimationOptions.AllowUserInteraction,
                                       animations: {
                                        self.nextButton.transform = CGAffineTransformIdentity
                }, completion: nil)

          
            
            //placeTheyChose.text = nextQuestion().name
            
            score = (score - thisTry.formatWithDecimalPlaces(1))
            
            var newscore = Int(score)
           
            
            self.placeChosen.text = ("Your Score: \(score)")
            
            questionIdx += 1
            Scoring.sharedGameData.mapsscore = newscore
            
            
            if score < 0.0 {
                newscore = 0
                Scoring.sharedGameData.mapsscore = newscore
                showAlert()
            }
            
        }
    
    func endAudio() {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("end_horn", ofType: "aiff")!))
            
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    
    func showAlert() {
        //var vc: UIViewController?
        let alertController = UIAlertController(title: "That's all the Maps!", message: "Time to tally your final score", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ayuh", style: .Default, handler: { (alert: UIAlertAction!) in
            
            self.performSegueWithIdentifier("ScoreSegue", sender: self)
            
            NSNotificationCenter.defaultCenter().postNotificationName("endOfRoundFour", object: self)
            
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

