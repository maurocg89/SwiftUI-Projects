//
//  Resort.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let resortsFileName = "resorts.json"
    static let allResorts: [Resort] = Bundle.main.decode(resortsFileName)
    static let example = allResorts[0]
}
