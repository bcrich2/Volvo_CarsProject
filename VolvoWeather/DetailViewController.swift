//
//  DetailViewController.swift
//  VolvoWeather
//
//  Created by Macbook on 8/21/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation


import UIKit

class DetailViewController: UIViewController {
    
     let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
    
    var theweather: String?
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var weatherStateLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        
        view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        
        
        
        getData(link: theweather!) {(image_abbr) in
        
            if let myimage_abbr = image_abbr{
                //calling wev services for the image
                self.myImage.downloadedFrom(link: "https://www.metaweather.com/static/img/weather/png/\(myimage_abbr).png")
            }
            
        }

    }
    
        //taking
        func getData(link:String, callback: @escaping (String?) -> Void){
        
            NetworkingManager.sharedInstance.getData(city: link) {(locations) in
            
           
              DispatchQueue.main.async {
                callback(locations?.weather_state_abbr)
            
            self.activityIndicator.stopAnimating()
           
                
               if let the_temp = locations?.the_temp,
                let max_temp = locations?.max_temp,
                let min_temp = locations?.min_temp,
                let weather_state_name = locations?.weather_state_name

            {
                // self.titleLab
                self.tempLbl.text = NSString(format: "%.2f°C", the_temp) as String
                self.maxTempLbl.text = NSString(format: "%.2f°C", max_temp) as String
                self.minTempLbl.text = NSString(format: "%.2f°C", min_temp) as String

                self.weatherStateLbl.text = weather_state_name
                self.locationLbl.text = self.theweather

            }
            else{
                self.tempLbl.text = "no result"
                self.maxTempLbl.text = "no result"
                self.minTempLbl.text = "no result"

                self.weatherStateLbl.text = "no result"
                self.locationLbl.text = "no result"

            }
            }
            
        }
    }
    
}
