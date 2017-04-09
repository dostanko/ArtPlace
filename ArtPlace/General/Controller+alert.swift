//
//  Controller+alert.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showErrorAllert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


