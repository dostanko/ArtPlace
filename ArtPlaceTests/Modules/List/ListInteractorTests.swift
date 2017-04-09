//
//  ListInteractorTests.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest

@testable import ArtPlace


class ListInteractorTests: XCTestCase {
    
    let interactor = ListInteractor()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetPlacesAnnotations ()  {
        
        interactor.storage = MockStorage1()
        interactor.getPlacesAnnotations  { status, places in
            switch status {
            case .error:
                XCTFail()
            case .ok:
                print("do nothing")
            }
        }
        
        interactor.storage = MockStorage2()
        interactor.getPlacesAnnotations  { status, places in
            switch status {
            case .error:
                print("do nothing")
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
