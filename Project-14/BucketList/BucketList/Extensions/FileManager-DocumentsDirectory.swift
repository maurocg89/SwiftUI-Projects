//
//  FileManager+Functions.swift
//  Moonshot
//
//  Created by Mauro Grillo on 18/08/2023.
//

import Foundation

extension FileManager {

    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func saveFile(_ fileName: String, _ content: String) {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            try content.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Failed to save \(fileName). Error: \(error.localizedDescription)")
        }
    }

    func getFile(_ fileName: String) -> String {
        let url = Self.documentsDirectory.appending(path: fileName)
        do {
            let input = try String(contentsOf: url)
            return input
        } catch {
            fatalError("Failed to get \(fileName). Error: \(error.localizedDescription)")
        }
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
}
