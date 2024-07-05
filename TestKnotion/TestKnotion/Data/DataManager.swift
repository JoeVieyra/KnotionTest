//
//  DataManager.swift
//  TestKnotion
//
//  Created by user264681 on 7/5/24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
      
      private init() {}
      
      func deletePerson(person: Person, from people: inout [Person]) {
          if let index = people.firstIndex(where: { $0.id == person.id }) {
              people.remove(at: index)
              saveToJSON(people:people)          }
      }
    
    func saveToJSON(people: [Person]) {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            do {
                let data = try encoder.encode(people)
                guard let url = DataManager.getDocumentsDirectory()?.appendingPathComponent("example.json") else { return  }
                try data.write(to: url)
            } catch {
                print("Error al guardar los datos: \(error)")
            }
        }
    
    static func loadPeople() -> [Person] {
        guard let url = getDocumentsDirectory()?.appendingPathComponent("example.json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Person].self, from: data)
        } catch {
            print("Error loading data: \(error)")
            return []
        }
    }
    
    static func savePeople(_ people: [Person]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(people)
            guard let url = getDocumentsDirectory()?.appendingPathComponent("example.json") else {
                return
            }
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    private static func getDocumentsDirectory() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
