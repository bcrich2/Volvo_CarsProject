//
//  ViewController.swift
//  VolvoWeather
//
//  Created by Macbook on 8/21/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var locations: [Location] = []
    
    var arrayOfCities = ["Gothenburg", "Stockholm", "Mountain View", "London", "New York", "Berlin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
      
    }
        
     override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "showDetail" {
                if let indexPath = self.myTableView.indexPathForSelectedRow {
                    let controller = segue.destination as! DetailViewController
                    
                    
                    controller.theweather = arrayOfCities[indexPath.row]
                    //controller.sdbname = schools[indexPath.row].dbn
                }
            }
        }
        
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if arrayOfCities.count == 0{
            // self.titleLab
            return 1
        }
        
        
        return arrayOfCities.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        
        
        if arrayOfCities.count == 0{
           
            cell.cityLbl.text = "No Results"
            return cell
        }
        
        
        cell.cityLbl.text = arrayOfCities[indexPath.row] + "🌤"
        
        return cell
    }
    
}


