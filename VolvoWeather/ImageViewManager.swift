//
//  ImageViewManager.swift
//  VolvoWeather
//
//  Created by Macbook on 8/21/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import UIKit


//calling wev services for the image
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        
        let session = URLSession(configuration: .default)
        
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                      
                        let image = UIImage(data: imageData)
                        
                        DispatchQueue.main.async ( ) {
                        self.image = image
                        }
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
      
        
    }
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url)
    }
}




