//
//  ListController.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit
import CoreData
import MapKit

struct ListArtPlacePO {
    let text : String
    let detailText : String
    let title : String
    let objetctID : NSManagedObjectID
    let comments : String
    let coordinate : CLLocationCoordinate2D
}

class ListController : UITableViewController {
    
    let helper = ListHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.contoller = self
        tableView.delegate = helper
        tableView.dataSource = helper
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsController = segue.destination as? DetailsController {
            detailsController.artPlace = helper.preparedDetailsPO()
        }
    }


}
