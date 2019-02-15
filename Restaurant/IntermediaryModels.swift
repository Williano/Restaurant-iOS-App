//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by William Kpabitey Kwabla on 2/15/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


struct Categories: Codable {
    let categories: [String]
}


struct PreparationTime: Codable {
    let prepTime: Int
    
        enum CodingKeys: String, CodingKey {
            case preptime = "preparation_time"
    }
}
