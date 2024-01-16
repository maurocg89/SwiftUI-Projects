//
//  User.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 30/06/2023.
//

import Foundation

class User: Codable, ObservableObject {
    @Published var name = "Paul Hudson"

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }

    enum CodingKeys: CodingKey {
        case name
    }
}
