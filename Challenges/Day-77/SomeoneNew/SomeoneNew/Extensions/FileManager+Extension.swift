//
//  FileManagert.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import Foundation

extension FileManager {

    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func saveData<T: Codable>(_ fileName: String, _ content: T) {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            let data = try JSONEncoder().encode(content)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            print("Failed to save \(fileName)")
        }
    }

    func getData<T: Codable>(_ fileName: String) -> T? {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("Failed to load \(fileName)")
            return nil
        }
    }

    func resetData(_ fileName: String) {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            if (try? self.fileExists(atPath: String(contentsOf: url))) != nil {
                try self.removeItem(at: url)
            }
        } catch {
            print("Failed to remove \(fileName)")
        }
    }

}
