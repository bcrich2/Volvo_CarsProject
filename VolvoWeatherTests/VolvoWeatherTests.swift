//
//  VolvoWeatherTests.swift
//  VolvoWeatherTests
//
//  Created by Macbook on 8/21/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import XCTest
@testable import VolvoWeather

class VolvoWeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    //gettinf the woeid
    func testExample() {
       
        
        guard let endPointURL = URL(string:"https://www.metaweather.com/api/location/search/?query=london")
            
            else { return }
        
        let currentSession = URLSession(configuration: .default)
        currentSession.dataTask(with: endPointURL) { (data, response, error) in
            
            
            let expectation = XCTestExpectation(description: "Download from www.metaweather.com page")
            if let httpResponse = response as? HTTPURLResponse{
                
                XCTAssert(httpResponse.statusCode == 200, "statusCode is not matching the server data")
                
                expectation.fulfill()
            }
            
            if let error = error {
                print(error)
                return
            }
            
            
            }
            .resume()
        
    }
    
    //Geting the weather data
    func testRest() {
        
        
        guard let endPointURL = URL(string:"https://www.metaweather.com/api/location/44418/") else { return }
        
        let currentSession = URLSession(configuration: .default)
        currentSession.dataTask(with: endPointURL) { (data, response, error) in
            
            
            let expectation = XCTestExpectation(description: "Download www.metaweather.com/api/location/44418/ page")
            if let httpResponse = response as? HTTPURLResponse{
                
                XCTAssertNotNil(data, "downloadJson failed to get data")
                
                expectation.fulfill()
            }
            
            if let error = error {
                print(error)
                return
            }
            
            
            
            
            }
            .resume()
        
    
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
