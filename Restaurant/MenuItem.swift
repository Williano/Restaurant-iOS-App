//
//  MenuItem.swift
//  Restaurant
//
//  Created by William Kpabitey Kwabla on 2/15/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case categroy
        case imageURL = "image_url"
        
    }
}


struct MenuItems: Codable {
    let items: [MenuItem]
}
