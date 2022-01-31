//
//  WeatherModel.swift
//  MYProjectios
//
//  Created by user203935 on 10/26/21.
//


import Foundation
struct WeatherResult: Codable{
    var weather:[Weather]?
    var main:Main
}

struct Weather: Codable{
    var icon: String
}
    
struct Main: Codable{
    var temp: Float
}
