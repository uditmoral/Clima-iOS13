//
//  WeatherModel.swift
//  Clima
//
//  Created by UDIT MORAL on 10/07/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    let weatherId: Int
    let cityName: String
    let temp: Double
    
    var temperatureString: String{
        let tempString = String(format: "%.1f", temp)
        return tempString
    }
    
    var weatherMode: String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
