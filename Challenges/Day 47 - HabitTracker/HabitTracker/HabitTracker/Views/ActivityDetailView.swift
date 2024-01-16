//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Mauro Grillo on 02/06/2023.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    var activity: ActivityItem

    var body: some View {
        VStack {
            Form {
                Section {
                    Text("\(activity.description)")
                    Text("Times completed: \(activity.timesCompleted)")
                }

                Section {
                    Button("Mark as complete") {
                        addOrResetCounter(reset: false)
                    }
                    .buttonStyle(.borderless)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                Section {
                    Button("Reset counter", role: .destructive) {
                        addOrResetCounter(reset: true)
                    }
                    .buttonStyle(.borderless)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

//            HStack(alignment: .center) {
//                Button("Mark as complete") {
//                    addOrResetCounter(reset: false)
//                }
//                .buttonStyle(.borderedProminent)
//
//                Button("Reset counter") {
//                    addOrResetCounter(reset: true)
//                }
//                .buttonStyle(.borderedProminent)
//                .tint(Color.red.opacity(0.8))
//            }
//            .frame(maxWidth: .infinity)
        }
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    func addOrResetCounter(reset: Bool) {
        if let index = activities.items.firstIndex(of: activity) {
            activities.items[index].timesCompleted = reset ? 0 : activity.timesCompleted + 1
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities.sampleData(), activity: Activities.sampleData().items[1])
    }
}
