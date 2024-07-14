//
//  WeatherForecast.swift
//  weather
//
//  Created by coji on 2024/07/14.
//

import Foundation

struct WeatherForecast {
  var id = UUID().uuidString
  let time: String
  let temperature: String
  let weather: Weather
}
