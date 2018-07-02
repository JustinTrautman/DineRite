//
//  RestaurantSearch.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/1/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

typealias PlacesCompletion = ([RestaurantSearch]) -> Void
typealias PhotoCompletion = (UIImage?) -> Void

class RestaurantSearchController {
    
    private var photoCache: [String: UIImage] = [:]
    private var placesTask: URLSessionDataTask?
    private var session: URLSession {
        return URLSession.shared
    }
    
    private struct APIconstants {
    
    static let GoogleApiKey = "AIzaSyBHh-f0KqLhwy828wB7HUYLOt81w4FhmZw"
    static let GooglePlaceSearchBaseURL = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=")
    static let GooglePhotoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference="
    }
    
    func fetchPlacesNearCoordinate(_ coordinate: CLLocationCoordinate2D, radius: Double, types:[String], completion: @escaping PlacesCompletion) -> Void {
        
        var urlString = "\(String(describing: APIconstants.GooglePlaceSearchBaseURL))\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true&key=\(APIconstants.GoogleApiKey)"
        
        let typesString = types.count > 0 ? types.joined(separator: "|") : "food"
        urlString += "&types=\(typesString)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        if let task = placesTask, task.taskIdentifier > 0 && task.state == .running {
            task.cancel()
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        placesTask = session.dataTask(with: url) { data, response, error in
            var placesArray: [RestaurantSearch] = []
            defer {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion(placesArray)
                }
            }
            guard let data = data,
                let json = try? JSON(data: data, options: .mutableContainers),
                let results = json["results"].arrayObject as? [[String: Any]] else {
                    return
            }
            results.forEach {
                let place = RestaurantSearch(dictionary: $0, acceptedTypes: types)
                placesArray.append(place)
            }
        }
        placesTask?.resume()
    }
    
    func fetchPhotoFromReference(_ reference: String, completion: @escaping PhotoCompletion) -> Void {
        if let photo = photoCache[reference] {
            completion(photo)
        } else {
            let urlString = "\(APIconstants.GooglePhotoURL)\(reference)&key=\(APIconstants.GoogleApiKey)"
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            
            session.downloadTask(with: url) { url, response, error in
                var downloadedPhoto: UIImage? = nil
                defer {
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        completion(downloadedPhoto)
                    }
                }
                guard let url = url else {
                    return
                }
                guard let imageData = try? Data(contentsOf: url) else {
                    return
                }
                downloadedPhoto = UIImage(data: imageData)
                self.photoCache[reference] = downloadedPhoto
                }
                .resume()
        }
    }
}
