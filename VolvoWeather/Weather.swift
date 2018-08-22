//
//  Weather.swift
//  VolvoWeather
//
//  Created by Macbook on 8/21/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation

class Weather {
    
    
    
    let max_temp: Float
    let min_temp: Float
    let the_temp: Float
    let weather_state_abbr: String
    let weather_state_name: String
    let applicable_date: String
    
    init(applicable_date: String, max_temp:Float, min_temp: Float, the_temp: Float, weather_state_abbr: String, weather_state_name: String) {
        self.applicable_date = applicable_date
        
        self.max_temp = max_temp
        self.min_temp = min_temp
        self.the_temp = the_temp
        self.weather_state_abbr = weather_state_abbr
        self.weather_state_name = weather_state_name
    }
    
    
}
