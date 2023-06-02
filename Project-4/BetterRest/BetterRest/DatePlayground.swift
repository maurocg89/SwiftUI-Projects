//
//  DatePlayground.swift
//  BetterRest
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct DatePlayground: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            DatePicker("Please enter a time", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
                .padding()
            
            Text(Date.now, format: .dateTime.hour().minute())
            
            Text(Date.now, format: .dateTime.day().month().year())
            
            Text(Date.now.formatted(date: .long, time: .shortened))
            
            Text(Date.now.formatted(date: .long, time: .omitted))
        }
    }
    
    func exampleDate() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
    
    func trivialExample() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

struct DatePlayground_Previews: PreviewProvider {
    static var previews: some View {
        DatePlayground()
    }
}
