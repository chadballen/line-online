//
//  RestaurantSelectController.swift
//  cse335project
//
//  Created by cballen3 on 11/17/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

//import Firebase
import UIKit
import MapKit

class RestaurantSelectController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var restaurantSearched: UIButton!
    
    
    var selectedRestaurant: MKPointAnnotation?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        map.delegate = self
        searchBar.delegate = self
        restaurantSearched.setTitle("", for: [])
        restaurantSearched.isEnabled = false
        
        // Display user's current loation
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        /*
        let lon: CLLocationDegrees = -111.9340
        let lat: CLLocationDegrees = 33.4185
        let coords = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(coords, span)
        self.map.setRegion(region, animated: true)
         */
        
        // Do any additional setup after loading the view.
    }
    
    func searchRestaurant(place: String) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        request.region = map.region
        let localSearch = MKLocalSearch(request: request)
        localSearch.start {response, _ in guard let response = response else {
            return
            }
            print(response.mapItems)
            var matchingItems: [MKMapItem] = []
            matchingItems = response.mapItems
            
            for i in 1...matchingItems.count-1 {
                let pm = matchingItems[i].placemark
                print(pm.name)
                // Add annotations to map
                let annote = MKPointAnnotation()
                annote.coordinate = pm.coordinate
                annote.title = pm.name
                annote.subtitle = pm.title
                self.map.addAnnotation(annote)
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("user's current location = \(locValue.latitude) \(locValue.longitude)")
        manager.stopUpdatingLocation()
        
        let coords = CLLocationCoordinate2D(latitude: CLLocationDegrees(locValue.latitude), longitude: CLLocationDegrees(locValue.longitude))
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(coords, span)
        self.map.setRegion(region, animated: true)
        
        // Show by default restaurants in your area
        searchRestaurant(place: "restaurant")
        searchRestaurant(place: "fast food")
        searchRestaurant(place: "food")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Restaurant Searched")
        
        let annotes = self.map.annotations
        self.map.removeAnnotations(annotes)
        
        searchRestaurant(place: searchBar.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ map: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedRestaurant = view.annotation as? MKPointAnnotation
        print(selectedRestaurant?.coordinate)
        print(selectedRestaurant!.title!)
        print(selectedRestaurant!.subtitle!)
        
        let restaurantName = selectedRestaurant!.title!
        let lastCharOfName = restaurantName.last!
        if lastCharOfName == "s" {
            restaurantSearched.setTitle("Check \(restaurantName)' line", for: .normal)
        }
        else {
            restaurantSearched.setTitle("Check \(restaurantName)'s line", for: .normal)
        }
        restaurantSearched.isEnabled = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tableView" {
            let navController = segue.destination as? UINavigationController
            let viewController = navController?.viewControllers.first as! RestaurantViewController
            viewController.restaurantName = selectedRestaurant?.title!
            viewController.restaurantAddress = selectedRestaurant?.subtitle!
            
            //restaurantLatitude =
            //restaurantLongitude =
        }
        
    }
    
    @IBAction func returned1(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? RestaurantViewController {
            print("unwind from restaurant table view")
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
