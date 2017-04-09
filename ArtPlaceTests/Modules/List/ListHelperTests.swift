//
//  ListHelperTests.swift
//  ArtPlace
//
//  Created by Ira on 4/8/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest
import CoreData
import MapKit


@testable import ArtPlace

class ListHelperTests: XCTestCase {
    
    let helper = ListHelper()
    let interactor = ListInteractor()
    let controller = ListController()
    var validStorageMock = MockStorage1()
    var errorsStorageMock = MockStorage2()
   
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testReloadData() {
        helper.interactor = interactor
        helper.contoller = controller
        helper.contoller?.tableView = UITableView()
        
        interactor.storage = validStorageMock
        helper.reloadData()
    
        let textForZeroCell = "title1\nlat: 20.1;lng: 10.1"
        
        XCTAssertEqual(helper.annotations.count, 2)
        let annotation = helper.annotations[0]
        XCTAssertEqual(annotation.text, textForZeroCell)
        XCTAssertEqual(annotation.title, "title1")
        XCTAssertEqual(annotation.comments, "comments1")
        XCTAssertEqual(annotation.coordinate.latitude, 20.1)
        XCTAssertEqual(annotation.coordinate.longitude, 10.1)
        XCTAssertEqual(helper.tableView(UITableView(), numberOfRowsInSection: 0), 2)
        
        XCTAssertNil(helper.selectedAnnotation())
        XCTAssertNil(helper.preparedDetailsPO())
        
        controller.tableView.selectRow(at: IndexPath(row: 0, section:0), animated: false,
                                       scrollPosition: UITableViewScrollPosition.none)
        
        
        let selectedAnnotation = helper.selectedAnnotation()
        XCTAssertEqual(selectedAnnotation?.title, annotation.title)
        
        let detailsPO = helper.preparedDetailsPO()
        XCTAssertEqual(detailsPO?.title, annotation.title)
        XCTAssertEqual(detailsPO?.comments, annotation.comments)
        XCTAssertEqual(detailsPO?.coordinate.latitude, annotation.coordinate.latitude)
        XCTAssertEqual(detailsPO?.coordinate.longitude, annotation.coordinate.longitude)
        
        
        interactor.storage = errorsStorageMock
        helper.reloadData()
        XCTAssertEqual(helper.annotations.count, 0)
        XCTAssertEqual(helper.tableView(controller.tableView, numberOfRowsInSection: 0), 0)
        
        XCTAssertNil(helper.selectedAnnotation())
        XCTAssertNil(helper.preparedDetailsPO())
    }
}

