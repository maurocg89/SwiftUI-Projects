//
//  ActivityItem.swift
//  HabitTracker
//
//  Created by Mauro Grillo on 02/06/2023.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var timesCompleted: Int
}
