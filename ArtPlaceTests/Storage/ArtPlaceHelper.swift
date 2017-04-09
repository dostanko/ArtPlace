//
//  ArtPlace+ModelTest.swift
//  ArtPlace
//
//  Created by Ira on 4/8/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest
import CoreData

@testable import ArtPlace



class ArtPlaceHelperTest: XCTestCase {
    
    var artPlaceHeper = ArtPlaceHeper()
    var validStorageMock = MockStorage1()
    var errorsStorageMock = MockStorage2()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateFromParams(){
        artPlaceHeper.storage = validStorageMock
        
        let place = try? artPlaceHeper.create(title: "Title1", comments: "Comment1", longitude: 10.1, latitude: 10.2)
        XCTAssertNotNil(place)
        
        artPlaceHeper.storage = errorsStorageMock
        XCTAssertThrowsError(try artPlaceHeper.create(title: "Title1", comments: "Comment1", longitude: 10.1, latitude: 10.2))
        
    }
    
    func testCreateFromJson(){
        artPlaceHeper.storage = validStorageMock
        let validJSON : [String : Any] = ["name" : "name", "lng" : 10.10, "lat" : 20.20]
        
        let place = try? artPlaceHeper.create(jsonPlace: validJSON)
         XCTAssertNotNil(place)
        
        let invalidJSON = ["name" : "name", "lng" : 10.10, "lat" : "error"] as [String : Any]
        
        XCTAssertThrowsError(try artPlaceHeper.create(jsonPlace: invalidJSON))
        
        artPlaceHeper.storage = errorsStorageMock
        XCTAssertThrowsError(try artPlaceHeper.create(jsonPlace: validJSON))

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
