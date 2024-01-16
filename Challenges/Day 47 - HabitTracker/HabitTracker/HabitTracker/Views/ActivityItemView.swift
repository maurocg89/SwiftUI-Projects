//
//  ActivityItemView.swift
//  HabitTracker
//
//  Created by Mauro Grillo on 02/06/2023.
//

import SwiftUI

struct ActivityItemView: View {
    let activity: ActivityItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.headline)
                Text(activity.description)
            }

            Spacer()

            CapsuleActivityCompleted(timesCompleted: activity.timesCompleted)
        }
    }
}

struct CapsuleActivityCompleted: View {
    let timesCompleted: Int

    var body: some View {
        Text("\(timesCompleted)")
            .font(.headline)
            .padding(10)
            .foregroundColor(.white)
            .background(backgroundColor())
            .clipShape(Circle())
    }

    func backgroundColor() -> Color {
        timesCompleted == 0 ? Color.red.opacity(0.6) : timesCompleted < 3 ? Color.yellow.opacity(0.8) : Color.green.opacity(0.8)
    }
}

struct ActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityItemView(activity: ActivityItem(title: "Test", description: "Test", timesCompleted: 2))
    }
}
