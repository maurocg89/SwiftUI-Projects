//
//  FileManager+Functions.swift
//  Moonshot
//
//  Created by Mauro Grillo on 18/08/2023.
//

import Foundation

// TODO: Make generics methods
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
}
