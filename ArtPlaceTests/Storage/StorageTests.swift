//
//  StorageTests.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest
import CoreData

@testable import ArtPlace


class StorageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPlaces() {
        Storage.access.artPlaceClass = ArtPlaceMock1()
        Storage.access.getPlaces { (status, places) -> (Void) in
            switch status {
            case .ok:
                XCTFail()
            case .error:
                print("do nothing")
            }
            XCTAssertEqual(places.count, 0)
        }
        Storage.access.artPlaceClass = ArtPlaceMock2()
        Storage.access.getPlaces { (status, places) -> (Void) in
            switch status {
            case .error:
                XCTFail()
            case .ok:
                print("do nothing")
            }
            XCTAssertEqual(places.count, 0)
        }
        
    }
    
    func testCreateArtPlace() {
        
        Storage.access.artPlaceClass = ArtPlaceMock1()
        Storage.access.createArtPlace(
            title: "", comments: "", longitude: 0, latitude: 0,
            callback: { (status, place) -> (Void) in
                switch status {
                case .ok:
                    XCTFail()
                case .error:
                    print("do nothing")
                }
        })
        
        Storage.access.artPlaceClass = ArtPlaceMock2()
        Storage.access.createArtPlace(
            title: "", comments: "", longitude: 0, latitude: 0,
            callback: { (status, place) -> (Void) in
                switch status {
                case .error:
                    XCTFail()
                case .ok:
                    print("do nothing")
                }
        })
        
    }
    
    func testUpdateArtPlace(){
        Storage.access.artPlaceClass = ArtPlaceMock1()
        Storage.access.updateArtPlace(objetctID: NSManagedObjectID(), title: "", comments: "") { (status) -> (Void) in
            switch status {
            case .error:
                print("do nothing")
            case .ok:
                XCTFail()
                
            }
        }
        
        Storage.access.artPlaceClass = ArtPlaceMock2()
        Storage.access.updateArtPlace(objetctID: NSManagedObjectID(), title: "", comments: "") { (status) -> (Void) in
            switch status {
            case .error:
                XCTFail()
            case .ok:
                print("do nothing")
            }
        }
    }
    
    
    func testDeleteArtPlace(){
        Storage.access.artPlaceClass = ArtPlaceMock1()
        Storage.access.deleteArtPlace(objetctID: NSManagedObjectID()) { (status) -> (Void) in
            switch status {
            case .error:
                print("do nothing")
            case .ok:
                XCTFail()
                
            }
        }
        
        Storage.access.artPlaceClass = ArtPlaceMock2()
        Storage.access.deleteArtPlace(objetctID: NSManagedObjectID()) { (status) -> (Void) in
            switch status {
            case .error:
                XCTFail()
            case .ok:
                print("do nothing")
            }
        }
    }
    
    func testLoadDefaultPlaces() {
        //load all 2 locations
        let locs1 = Storage.access.loadDefaultPlaces(filename: "locations1", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs1.count, 2)
        //ignore wrong json
        let locs3 = Storage.access.loadDefaultPlaces(filename: "locations3", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs3.count, 0)
        //ignore invalid json
        let locs4 = Storage.access.loadDefaultPlaces(filename: "locations4", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs4.count, 0)
        //ignore not existing file
        let locs5 = Storage.access.loadDefaultPlaces(filename: "locations5", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs5.count, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
