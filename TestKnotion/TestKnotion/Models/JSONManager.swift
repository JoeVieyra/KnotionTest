//
//  JSONManager.swift
//  TestKnotion
//
//  Created by user264681 on 7/5/24.
//

import Foundation
import SwiftUI
    
    struct Person: Codable, Identifiable {
        let id = UUID()
        let avatar: String
        let name, description: String
        let age: Int
        let job, phone, address: String

    
    // Generate samples
    static let allPeople: [Person] = Bundle.main.decode(file: "example.json")
    static let samplePerson: Person = allPeople[0]
}



// Extension to decode JSON locally
extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
