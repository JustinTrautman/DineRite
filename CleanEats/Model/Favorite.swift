//
//  Favorite.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/12/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class Favorite : Codable {
    let restaurantImage: String?
    let restaurantName: String
    let restaurantPrice: String?
    let restaurantRating: String?
    let restaurantPhone: String?
    let restaurantDescription: String?
    
    init(restaurantImage: String, restaurantName: String, restaurantPrice: String, restaurantRating: String, restaurantPhone: String, restaurantDescription: String) {
        
        self.restaurantImage = restaurantImage
        self.restaurantName = restaurantName
        self.restaurantPrice = restaurantPrice
        self.restaurantRating = restaurantRating
        self.restaurantPhone = restaurantPhone
        self.restaurantDescription = restaurantDescription
    }
}

extension Favorite : Equatable {
    static func ==(lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.restaurantImage == rhs.restaurantImage && lhs.restaurantName == rhs.restaurantName && lhs.restaurantPrice == rhs.restaurantPrice && lhs.restaurantRating == rhs.restaurantRating && lhs.restaurantPhone == rhs.restaurantPhone && lhs.restaurantDescription == rhs.restaurantDescription
        
    }
}