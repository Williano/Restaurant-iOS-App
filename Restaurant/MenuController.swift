//
//  MenuController.swift
//  Restaurant
//
//  Created by William Kpabitey Kwabla on 2/15/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!
    
    
    // Mark: - GET Requests
    
    // Get all categroies from the server.
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        // Create task
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
                let jsonDictionary = try?
                    JSONSerialization.jsonObject(with: data) as?
                        [String: Any],
                let categories = jsonDictionary?["categories"] as?
                    [String] {
                completion(categories)
            } else {
                completion(nil)
            }
          
        }
        
        // Make request to server
        task.resume()
    }
    
    // Get all menus from the server
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialURL = baseURL.appendingPathComponent("menu")
        
        // Add query parameter to URL
        var components = URLComponents(url: initialURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: "categoryName")]
        let menuURL = components.url!
        
        // Create Task.
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        
        // Make request to server.
        task.resume()
        
    }
    
    
    // MARK: - POSt Requests
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void){
        let orderURL = baseURL.appendingPathComponent("order")
        
        // Modify default request type from GET to POST
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Store array of Menu IDs in JSON
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        // Create Task.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        
        // Make request to server.
        task.resume()
        
    }
}
