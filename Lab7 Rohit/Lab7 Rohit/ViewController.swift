//
//  ViewController.swift
//  Lab7 Rohit
//
//  Created by Rohit Chauhan on 2024-07-23.
//
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var zoomSlider: UISlider!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var startLatitudeLabel: UILabel!
    @IBOutlet weak var endLatitudeLabel: UILabel!
    @IBOutlet weak var startLongitudeLabel: UILabel!
    @IBOutlet weak var endLongitudeLabel: UILabel!
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var bikeImageView: UIImageView!
    @IBOutlet weak var walkImageView: UIImageView!
    @IBOutlet weak var busImageView: UIImageView!
    
    // Location manager for handling user location updates
    let locationManager = CLLocationManager()
    
    // Variables to store start and end locations
    var startLocation: CLLocation?
    var endLocation: CLLocation?
    
    // Default transportation mode
    var transportationMode: MKDirectionsTransportType = .automobile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup mapView and locationManager
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Add targets for zoom slider and start button
        zoomSlider.addTarget(self, action: #selector(zoomSliderChanged), for: .valueChanged)
        startButton.addTarget(self, action: #selector(promptForLocations), for: .touchUpInside)
        
        // Add tap gestures to transportation mode image views
        addTapGesturesToImageViews()
        
        // Update background color to reflect current transportation mode
        updateTransportSelection()
    }
    
    // Add tap gestures to transportation mode image views
    func addTapGesturesToImageViews() {
        let carTapGesture = UITapGestureRecognizer(target: self, action: #selector(carSelected))
        carImageView.addGestureRecognizer(carTapGesture)
        carImageView.isUserInteractionEnabled = true
        
        let bikeTapGesture = UITapGestureRecognizer(target: self, action: #selector(bikeSelected))
        bikeImageView.addGestureRecognizer(bikeTapGesture)
        bikeImageView.isUserInteractionEnabled = true
        
        let walkTapGesture = UITapGestureRecognizer(target: self, action: #selector(walkSelected))
        walkImageView.addGestureRecognizer(walkTapGesture)
        walkImageView.isUserInteractionEnabled = true
        
        let busTapGesture = UITapGestureRecognizer(target: self, action: #selector(busSelected))
        busImageView.addGestureRecognizer(busTapGesture)
        busImageView.isUserInteractionEnabled = true
    }
    
    // Update UI to highlight the selected transportation mode
    func updateTransportSelection() {
        carImageView.backgroundColor = .clear
        bikeImageView.backgroundColor = .clear
        walkImageView.backgroundColor = .clear
        busImageView.backgroundColor = .clear
        
        switch transportationMode {
        case .automobile:
            carImageView.backgroundColor = .lightGray
        case .walking:
            walkImageView.backgroundColor = .lightGray
        case .transit:
            busImageView.backgroundColor = .lightGray
        case .any:
            bikeImageView.backgroundColor = .lightGray
        default:
            break
        }
    }
    
    // Methods to handle transportation mode selection
    @objc func carSelected() {
        transportationMode = .automobile
        updateTransportSelection()
    }
    
    @objc func bikeSelected() {
        transportationMode = .any
        updateTransportSelection()
    }
    
    @objc func walkSelected() {
        transportationMode = .walking
        updateTransportSelection()
    }
    
    @objc func busSelected() {
        transportationMode = .transit
        updateTransportSelection()
    }

    //Method to handle zoom slider
    @objc func zoomSliderChanged() {
        let zoomLevel = zoomSlider.value
        guard let start = startLocation, let end = endLocation else {
            return
        }
        
        let middleLatitude = (start.coordinate.latitude + end.coordinate.latitude) / 2
        let middleLongitude = (start.coordinate.longitude + end.coordinate.longitude) / 2
        let middlePoint = CLLocationCoordinate2D(latitude: middleLatitude, longitude: middleLongitude)
        
        let latitudeDelta = abs(start.coordinate.latitude - end.coordinate.latitude) * CLLocationDegrees(zoomLevel)
        let longitudeDelta = abs(start.coordinate.longitude - end.coordinate.longitude) * CLLocationDegrees(zoomLevel)
        
        let region = MKCoordinateRegion(center: middlePoint, span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
        
        mapView.setRegion(region, animated: true)
    }

    // Method to prompt the user for start and end locations
    @objc func promptForLocations() {
        let alert = UIAlertController(title: "", message: "Where would you like to go? Enter your destination", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Start Location"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "End Location"
        }
        
        let addAction = UIAlertAction(title: "Directions", style: .default) { [unowned self] _ in
            let startText = alert.textFields?[0].text
            let endText = alert.textFields?[1].text
            
            if startText?.isEmpty == false {
                geocode(address: startText!) { location in
                    self.startLocation = location
                    self.handleLocations()
                }
            } else {
                self.startLocation = self.locationManager.location
                self.handleLocations()
            }
            
            if endText?.isEmpty == false {
                geocode(address: endText!) { location in
                    self.endLocation = location
                    self.handleLocations()
                }
            }
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // Method to handle the geocoded start and end locations
    func handleLocations() {
        guard let start = startLocation, let end = endLocation else { return }
        
        // Add annotations for start and end locations
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = start.coordinate
        startAnnotation.title = "Start"
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = end.coordinate
        endAnnotation.title = "End"
        
        mapView.addAnnotations([startAnnotation, endAnnotation])
        
        // Request directions between start and end locations
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end.coordinate))
        request.transportType = transportationMode
        
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let route = response?.routes.first else { return }
            
            // Add the route overlay to the map
            self.mapView.addOverlay(route.polyline)
            
            // Update distance label and coordinate labels
            let distanceString = "\(route.distance / 1000) km"
            self.distanceLabel.text = "Distance : \(distanceString)"
            self.startLatitudeLabel.text = "Start Lat: \(start.coordinate.latitude)"
            self.startLongitudeLabel.text = "Start Long: \(start.coordinate.longitude)"
            self.endLatitudeLabel.text = "End Lat: \(end.coordinate.latitude)"
            self.endLongitudeLabel.text = "End Long: \(end.coordinate.longitude)"
            
            // Adjust the map view to show the entire route
            let mapRect = route.polyline.boundingMapRect
            let edgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            self.mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
        }
    }
    
    // Method to geocode an address string into a CLLocation
    func geocode(address: String, completion: @escaping (CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            completion(placemarks?.first?.location)
        }
    }
    
    // MKMapViewDelegate method to render the route overlay
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    // CLLocationManagerDelegate method to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            mapView.setRegion(region, animated: true)
            
            // Drop a pin at the user's current location
            let userAnnotation = MKPointAnnotation()
            userAnnotation.coordinate = location.coordinate
            userAnnotation.title = "You are here"
            mapView.addAnnotation(userAnnotation)
            
            // Stop updating to save battery life
            locationManager.stopUpdatingLocation()
        }
    }
}
