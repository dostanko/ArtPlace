//
//  ListHelper.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit

class ListHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    let listCellId = "ListCell"
    
    var contoller : ListController? {
        didSet {
          
        }
    }
    var interactor = ListInteractor()
    
    var annotations : [ListArtPlacePO] = []
    
    func reloadData(){
        interactor.getPlacesAnnotations {[weak self] status, annotations in
            switch status {
            case .ok:
                self?.annotations = annotations!
            case .error(let message):
                self?.annotations = []
                self?.contoller?.showErrorAllert(message: message)
            }
        }
        contoller?.tableView.reloadData()
    }
    
    func preparedDetailsPO() -> DetailsArtPlacePO? {
        if  let selectedListViewModel = selectedAnnotation() {
            let detailsViewModel = DetailsArtPlacePO(objetctID: selectedListViewModel.objetctID,
                                                     title: selectedListViewModel.title,
                                                     comments: selectedListViewModel.comments,
                                                     coordinate: selectedListViewModel.coordinate)
            return detailsViewModel
        }
        return nil
    }

    func selectedAnnotation() -> ListArtPlacePO? {
        guard let row = contoller?.tableView.indexPathForSelectedRow?.row
            else { return nil }
        return annotations[row]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let annotation = annotations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellId, for: indexPath)

        cell.textLabel?.text = annotation.text
        cell.detailTextLabel?.text = annotation.detailText
        return cell
    }

}
