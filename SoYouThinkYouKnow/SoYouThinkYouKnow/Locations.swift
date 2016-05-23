//
//  Locations.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/31/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import Foundation
import CoreLocation

struct Place {
    let name: String
    let location: CLLocation
    let hint: String
    let audio: String
}

let place = [

Place(name: "York", location: CLLocation(
latitude: 43.161748,
longitude: -70.648258),
hint: "Click on Maine's oldest town/city",
    audio: "map_oldest_town"),

Place(name:"Bangor", location: CLLocation(
latitude: 44.801182,
longitude: -68.777814),
hint: "Click on Maine's third largest city/town", audio: "map_third_largest_city"),

Place(name:"Skowhegan",location: CLLocation(
latitude: 44.765037,
longitude: -69.71938),
hint: "Click on Maine's oldest running fair", audio: "map_oldest_fair"),

Place(name:"Bar Harbor",location: CLLocation(
latitude: 44.387612,
longitude: -68.203912),
hint: "Click on home of Maine’s only National Park", audio: "map_national_park"),

Place(name:"Portland", location: CLLocation(
latitude: 43.661471,
longitude: -70.255326),
hint: "Click on Maine's original capital city", audio: "map_original_capital"),

Place(name:"Baxter State Park", location: CLLocation(
latitude: 45.908585,
longitude: -68.876038),
hint: "Click on Maine's highest point", audio: "map_highest_point"),

Place(name:"Fort Kent",location: CLLocation(
latitude: 47.258650,
longitude: -68.589491),
hint: "Click on University of Maine at Fort Kent", audio: "map_umfk"),

Place(name:"Waterville", location: CLLocation(
latitude: 44.552011,
longitude: -69.631712),
hint: "Click on the Elm City, home of Colby College", audio: "map_elm_city"),

Place(name:"Farmington", location: CLLocation(
latitude: 44.670500,
longitude: -70.151217),
hint: "Click on the home of the Beavers and Chester Greenwood(inventor of the ear muffs)", audio: "map_home_of_beavers"),

Place(name:"Freeport", location: CLLocation(
latitude: 43.857006,
longitude: -70.10312),
hint: "Click on the home of L.L. Bean", audio: "map_llbean"),


]
