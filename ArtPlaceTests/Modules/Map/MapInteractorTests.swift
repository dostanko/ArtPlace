//
//  MapInteractorTests.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest
import MapKit
import CoreData

@testable import ArtPlace

class MapInteractorTests: XCTestCase {
    
    let interactor = MapInteractor()
    let coordinate = CLLocationCoordinate2D()
    let validStorage = MockStorage1()
    let errorsStorage = MockStorage2()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreatePlace() {
        interactor.storage = validStorage
        interactor.createPlace(coordinate: coordinate, callback: {status, place in
            switch status {
            case .error:
                XCTFail()
            case .ok:
                print("do nothing")
            }
        })
        
        interactor.storage = errorsStorage
        interactor.createPlace(coordinate: coordinate, callback: {status, place in
            switch status {
            case .error:
                print("do nothing")
            case .ok:
                XCTFail()
            }
        })
    }
    
    func testGetPlacesAnnotations() {
        interactor.storage = validStorage
        interactor.getPlacesAnnotations() { status, places in
            switch status {
            case .error:
                XCTFail()
            case .ok:
                XCTAssertEqual(places?.count, 2)
            }
        }
        
        interactor.storage = errorsStorage
        interactor.getPlacesAnnotations() { status, places in
            switch status {
            case .error:
                XCTAssertNil(places?.count)
            case .ok:
                XCTFail()
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
