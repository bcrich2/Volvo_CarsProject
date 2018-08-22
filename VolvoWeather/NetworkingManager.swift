//
//  NetworkingManager.swift
//  VolvoWeather
//
//  Created by Macbook on 8/21/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import UIKit
class NetworkingManager{
    
    static let sharedInstance = NetworkingManager()
    
    
    private init(){}

    
    func getData(city:String, callback: @escaping (Weather?) -> Void){
        var locations: Weather? = nil
        
        let thecityurl = city.encodeUrl()!
        
        guard let endPointURL = URL(string:"https://www.metaweather.com/api/location/search/?query=\(thecityurl)")
            
        else { return }
        
        let currentSession = URLSession(configuration: .default)
        currentSession.dataTask(with: endPointURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let validData = data {
                
                self.jsonData(data: validData, callback: { (weather) in
                        callback(weather)
                })
                
            }
        }
            .resume()
    }
    
    func jsonData(data: Data,callback: @escaping (Weather?) -> Void) {
        
        var locations: Weather? = nil
        
        do {
            let jsonData1  = try JSONSerialization.jsonObject(with: data, options: [])  as? [[String:Any]]
            
            guard let locationResults = jsonData1  else {
                print("error when casting jsonData to [String: AnyObject]")
                return
            }
            
            //Taking the woeid from dictionary
            if locationResults.count > 0 {
                 let thelocation = locationResults[0]
                
                    guard let woeidname = thelocation["woeid"] as? Int,
                        let titlename = thelocation["title"] as? String
                        
                        else  {
                            
                            return
                    }
                
                
                var locationsinfo = Location(woeid: "\(woeidname)" )
                    
                    
                    guard let endPointURL = URL(string:"https://www.metaweather.com/api/location/\(locationsinfo.woeid)/") else { return}
                    
                    let currentSession = URLSession(configuration: .default)
                        currentSession.dataTask(with: endPointURL) { (data, response, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        
                        if  let jsonData2  = try? JSONSerialization.jsonObject(with: data!, options: [])  as? [String:Any]{
                        
                            if let validData = jsonData2 {
                                
                                guard let consolidated_weather = validData["consolidated_weather"] as? [[String:Any]]  else {
                                    return
                                }
                              
                                //Retrieving the weather data for tomorrow taken from second element of the array
                                if consolidated_weather.count > 0 {
                                    
                                    let weatherDic = consolidated_weather[1]
                                     print("weatherDic is  \(weatherDic)")
                                
                    
                                    guard  let applicable_date = weatherDic["applicable_date"] as? String,
                        
                                    let max_temp = weatherDic["max_temp"] as? Float,
                                    let min_temp = weatherDic["min_temp"] as? Float,
                                    let the_temp = weatherDic["min_temp"] as? Float,
                                    let weather_state_abbr = weatherDic["weather_state_abbr"] as? String,
                                    let weather_state_name = weatherDic["weather_state_name"] as? String
                                    
                                    else {return}
                                    
                                    
                                    locations = Weather(applicable_date: applicable_date, max_temp: max_temp, min_temp: min_temp, the_temp: the_temp, weather_state_abbr: weather_state_abbr, weather_state_name: weather_state_name)
                                    
                                    print(locations)
                                    callback(locations)
                                    
                                }
                                
                            }
                            
                        
                        }
                        
                        }
                        .resume()
                
            }
            
        
        } catch {
            print(error)
        }
}
}


extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}


