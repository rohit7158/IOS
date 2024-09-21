//
//  ViewController.swift
//  lab8Networking
//
//  Created by Rohit Chauhan on 2024-08-03.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    let locationManager = CLLocationManager()

       override func viewDidLoad() {
           super.viewDidLoad()
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           let lat = location.coordinate.latitude
           let lon = location.coordinate.longitude
           fetchWeatherData(lat: lat, lon: lon)
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Location update error: \(error.localizedDescription)")
           // Handle location error (e.g., show an alert to the user)
       }

       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .denied {
               print("Location access denied")
               // Handle the case where the user has denied location access
           }
       }

       func fetchWeatherData(lat: Double, lon: Double) {
           WeatherService().fetchWeatherData(lat: lat, lon: lon) { [weak self] weatherData, error in
               DispatchQueue.main.async {
                   guard let self = self else { return }
                   if let error = error {
                       print("Error fetching weather data: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let weatherData = weatherData else {
                       print("No weather data available")
                       return
                   }
                   
                   self.cityNameLabel.text = weatherData.name
                   self.weatherDescriptionLabel.text = weatherData.weather.first?.description
                   self.temperatureLabel.text = "\(weatherData.main.temp)°"
                   self.humidityLabel.text = "Humidity: \(weatherData.main.humidity)%"
                   
                   // Convert wind speed from m/s to km/h
                   let windSpeedKmh = Int(weatherData.wind.speed * 3.6)
                   self.windSpeedLabel.text = "Wind Speed: \(windSpeedKmh) km/h"
                   
                   if let icon = weatherData.weather.first?.icon {
                       let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                       if let iconURL = iconURL {
                           self.loadImage(from: iconURL)
                       }
                   }
               }
           }
       }

       private func loadImage(from url: URL) {
           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               if let error = error {
                   print("Error loading image: \(error.localizedDescription)")
                   return
               }
               
               guard let data = data, let image = UIImage(data: data) else {
                   print("Invalid image data")
                   return
               }
               
               DispatchQueue.main.async {
                   self?.weatherIconImageView.image = image
               }
           }.resume()
       }
   }
