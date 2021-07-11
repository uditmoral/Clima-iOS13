//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButton(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
  
}

extension WeatherViewController: WeatherManagerDelegate {
    
      func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel){
          DispatchQueue.main.async {
              self.temperatureLabel.text = weather.temperatureString
              self.conditionImageView.image = UIImage(systemName: weather.weatherMode)
              self.cityLabel.text = weather.cityName
              
          }
          
      }
      
      func didFailWithError(error: Error) {
          print(error)
      }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
