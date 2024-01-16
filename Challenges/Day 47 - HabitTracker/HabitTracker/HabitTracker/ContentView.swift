//
//  ContentView.swift
//  HabitTracker
//
//  Created by Mauro Grillo on 01/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(activities.items) { activity in
                        NavigationLink {
                            ActivityDetailView(activities: activities, activity: activity)
                        } label: {
                            ActivityItemView(activity: activity)
                        }
                    }
                    .onDelete(perform: removeRows(at:))
                } header: {
                    Text("Activities")
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddActivity = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
