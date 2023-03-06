//
//  DataModel.swift
//  Camera Photo File
//
//  Created by Shishir_Mac on 6/3/23.
//

import Foundation

struct DataModel: Codable {
    let text: String
}

// MARK: - Fileable
extension DataModel: Fileable {
    
    func write(to fileURLComponents: FileURLComponents) throws -> URL {
        // Encode the object to JSON data.
        let data = try JSONEncoder().encode(self)
        // Write the data to a file using the File class.
        return try File.write(data, to: fileURLComponents)
    }
    
    static func read<T: Decodable>(_ type: T.Type, from fileURLComponents: FileURLComponents) throws -> T {
        // Read the sample data from the file.
        let data = try File.read(from: fileURLComponents)
        // Decode the JSON data into an object.
        return try JSONDecoder().decode(type, from: data)
    }
    
    static func delete(_ fileURLComponents: FileURLComponents) throws -> Bool {
        // Delete the file at the file URL component's location
        return try File.delete(fileURLComponents)
    }
}

// MARK: - Equatable
extension DataModel: Equatable {
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        return lhs.text == rhs.text
    }
}
