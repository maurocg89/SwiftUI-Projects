//
//  ResultTypePlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SwiftUI

struct ResultTypePlayground: View {
    @State private var output = ""
   
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
            .padding()
    }

    func fetchReadings() async {
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings."
        } catch {
            print("Download error")
        }

        // Reusable task
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings."
        }
        
        // It could contain an error, so we must handle it.
        let result = await fetchTask.result

//        do {
//            output = try result.get()
//        } catch {
//            print("Download error")
//        }

        // Better approach.
        switch result {
        case .success(let success):
            output = success
        case .failure(let failure):
            output = "Download error: \(failure.localizedDescription)"
        }
    }
}

#Preview {
    ResultTypePlayground()
}
