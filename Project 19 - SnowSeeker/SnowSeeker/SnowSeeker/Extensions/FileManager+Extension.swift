//
//  FileManager+Extension.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 24/01/2024.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func loadData<T: Codable>(_ fileName: String) -> T? {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            debugPrint("Failed to load \(fileName)")
            debugPrint("Error: \(error.localizedDescription)")
            return nil
        }
    }

    func saveData<T: Codable>(_ fileName: String, _ content: T) {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            let encodedData = try JSONEncoder().encode(content)
            try encodedData.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            debugPrint("Failed to save \(fileName)")
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}
