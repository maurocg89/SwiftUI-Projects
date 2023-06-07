//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Mauro Grillo on 02/06/2023.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description, axis: .vertical)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    guard !title.isEmpty, !description.isEmpty else {
                        showAlert = true
                        return
                    }
                    let activity = ActivityItem(title: title, description: description, timesCompleted: 0)
                    activities.items.append(activity)
                    dismiss()
                }
            }
            .alert("Invalid Data", isPresented: $showAlert) {} message: {
                Text("Please, complete all the fields")
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
