//
//  Storage.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreData

enum CallbackStatus {
    case ok(String)
    case error(String)
}

enum StorageError : Error {
    case create(String)
    case update(String)
    case delete(String)
}

typealias GetPlacesCallback = (_ status: CallbackStatus,  _ places: [ArtPlace]) -> (Void)
typealias CreateArtPlaceCallback = (_ status: CallbackStatus, _ place: ArtPlace?) -> (Void)
typealias UpdateArtPlaceCallback = (_ status: CallbackStatus) -> (Void)
typealias DeleteArtPlaceCallback = (_ status: CallbackStatus) -> (Void)

protocol ManagablePlaces {
    func getPlaces(callback: GetPlacesCallback)
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback)
    func deleteArtPlace(objetctID : NSManagedObjectID, callback: DeleteArtPlaceCallback)
    func updateArtPlace(objetctID : NSManagedObjectID, title : String, comments : String, callback: UpdateArtPlaceCallback)
    func getEntity<Element : NSManagedObject>(t: Element?) -> Element?
    func saveContext ()
    static var access : ManagablePlaces { get set }
    static var context : NSManagedObjectContext { get set}
    var artPlaceClass : ArtPlaceHeper { get set }
    func loadDefaultPlaces(filename: String, bundle : Bundle) -> [[String: Any]]
}

class Storage : ManagablePlaces  {


    static var access : ManagablePlaces = Storage()
    static var context : NSManagedObjectContext = Storage.initContext()
    
    let delfaultLocationsFile = "locations"
    let locationsLoadedFlag = "fileLoaded"
    lazy var artPlaceClass = ArtPlaceHeper()
    
    private init() { }
    
    class func initContext() -> NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: "ArtPlace")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return persistentContainer.viewContext
    }
    
    func getPlaces(callback: GetPlacesCallback) {
        if !UserDefaults.standard.bool(forKey: locationsLoadedFlag) {
            for jsonPlace in loadDefaultPlaces(filename: delfaultLocationsFile, bundle: Bundle.main) {
                let _ = try? artPlaceClass.create(jsonPlace: jsonPlace)
            }
            UserDefaults.standard.set(true, forKey: locationsLoadedFlag)
        }
        if let places = try?  artPlaceClass.getAll() {
            callback(.ok(""), places)
        } else {
            callback(.error("Can't get Art Places"), [])
        }
    }
    
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback) {
        do {
           let place = try artPlaceClass.create(title: title, comments: comments, longitude: longitude, latitude: latitude)
            callback(.ok(""), place)
        } catch let error as NSError {
            callback(.error(error.localizedDescription), nil)
        }
    }
    
    func updateArtPlace(objetctID : NSManagedObjectID, title : String, comments : String, callback: UpdateArtPlaceCallback) {
        do {
           try artPlaceClass.update(objetctID : objetctID, title: title, comments: comments)
            callback(.ok(""))
        } catch let error as NSError {
            callback(.error(error.localizedDescription))
        }
    }
    
    func deleteArtPlace(objetctID : NSManagedObjectID, callback: DeleteArtPlaceCallback) {
        do {
            try artPlaceClass.delete(objetctID : objetctID)
            callback(.ok(""))
        } catch let error as NSError {
            callback(.error(error.localizedDescription))
        }
    }
    
    func loadDefaultPlaces(filename: String, bundle : Bundle) -> [[String: Any]] {
        if let file = bundle.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: file),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonPlaces = (json as? [String: Any])?["locations"] as? [[String: Any]] {
            return jsonPlaces
        } else {
            print("Invalid file or format")
            return []
        }
    }

    func getEntity<Element : NSManagedObject>(t: Element?) -> Element? {
        let entity = NSEntityDescription.entity(forEntityName: String.classToString(Element.self), in: Storage.context)!
        return NSManagedObject(entity: entity, insertInto: Storage.context) as? Element
    }
    
    func saveContext () {
        guard Storage.context.hasChanges
            else { return }
        do {
            try Storage.context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

