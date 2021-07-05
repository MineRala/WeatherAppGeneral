//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import Foundation


class WeatherModel: Codable {
    var cod : String = ""
    var message : Int = 0
    var cnt : Int = 0
    var list : [List]?
    var city : City?
    
    enum CodingKeys : String,CodingKey{
        case list = "list"
        case city = "city"
    }
}

class List: Codable {
    var dt : Int? = 0
    var main : Main?
    var weather : [Weather] = []
    var clouds : Clouds
    var wind : Wind
    var visibility : Int = 0
    var pop : Double = 0.0
    var rain : Rain?
    var sys : Sys
    var dt_txt : String = ""

    func date() -> Date {
        let timeInterval = TimeInterval(self.dt ?? 0)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date 
    }
    
    func dateWithFormat() -> String {
        let timeInterval = TimeInterval(self.dt ?? 0)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    
    func weatherIcon() -> String {
        guard let currWeather = weather.first else { return "" }
        return currWeather.icon.convertToIconName()
    }
    
    func degreeValue() -> String {
        guard let main = main else { return "" }
        return "\(main.temp)"
    }
}

class City: Codable {
    var id : UInt
    var name : String = ""
    var coord : Coord
    var country : String = ""
    var population : Int = 0
    var timezone : Int = 0
    var sunrise : UInt
    var sunset : UInt
}

class Main: Codable {
    var temp : Double = 0.0
    var feels_like : Double = 0.0
    var temp_min : Double = 0.0
    var temp_max : Double = 0.0
    var pressure : Int = 0
    var sea_level : Int = 0
    var grnd_level : Int = 0
    var humidity : Int = 0
    var temp_kf : Double = 0.0
}

class Weather: Codable {
    var id : Int = 0
    var main : String = ""
    var description : String = ""
    var icon : String = ""
}

class Clouds: Codable {
    var all : Int = 0
}

class Wind: Codable {
    var speed : Double = 0.0
    var deg : Int = 0
    var gust : Double = 0.0
}

class Rain: Codable {
    var rainyVolume : Double = 0.0
    
    enum CodingKeys : String,CodingKey{
        case rainyVolume = "3h"
    }
}

class Sys: Codable {
    var pod : String = ""
}

class Coord: Codable {
    var lat : Double = 0.0
    var lon : Double = 0.0
}


