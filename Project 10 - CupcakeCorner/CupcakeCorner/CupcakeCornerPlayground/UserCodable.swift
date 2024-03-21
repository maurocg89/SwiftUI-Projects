//
//  User.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 30/06/2023.
//

import Foundation

@Observable
class User: Codable {
    var name = "Paul Hudson"

//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
    
    // @Observable macro is quietly rewriting our class, so that it can be monitored by SwiftUI. We need to tell Swift exactly how it should encode and decode our data using a enum with a String raw value and a conformance to the CodingKey protocol
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
}
