//
//  Activities.swift
//  HabitTracker
//
//  Created by Mauro Grillo on 02/06/2023.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.activities)
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: UserDefaultsKeys.activities) {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                self.items = decodedItems
                return
            }
        }

        self.items = []
    }
}

extension Activities {

    static func sampleData() -> Activities {
        let activityItem = ActivityItem(title: "Title 1", description: "Description 1", timesCompleted: 0)

        let activityItem2 = ActivityItem(title: "Title 2", description: "Description 2\nWith multiples\nlines", timesCompleted: 3)

        let activityItem3 = ActivityItem(title: "Title 3", description: "Description 3", timesCompleted: 6)

        let activityItem4 = ActivityItem(title: "Title 4", description: "Description 4", timesCompleted: 9)

        let activities = Activities()
        activities.items = [activityItem, activityItem2, activityItem3, activityItem4]

        return activities
    }

}
