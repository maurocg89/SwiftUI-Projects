//
//  WorkingWithDataPlayground.swift
//  Navigation
//
//  Created by Mauro Grillo on 03/02/2024.
//

import SwiftUI

// MARK: Programmatic navigation with NavigationStack
struct WorkingWithDataPlayground: View {
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32") {
                    path = [32]
                }

                Button("Show 64") {
                    path.append(64)
                }

                Button("Show 32 then 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

// MARK: Navigating to different data types using NavigationPath
struct NavigationPathView: View {
    @State private var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }

                ForEach(0..<5) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .toolbar {
                Button("Push 556") {
                    navigationPath.append(556)
                }

                Button("Push Hello") {
                    navigationPath.append("Hello")
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
}

// MARK: How to make a NavigationStack return to its root view programmatically
struct DetailView2: View {
    var number: Int
//    @Binding var path: [Int]
    @Binding var path: NavigationPath

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
//                    path.removeAll()
                    path = NavigationPath()
                }
            }
    }
}

struct NavigationStackReturnToRoot: View {
//    @State private var path = [Int]
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            DetailView2(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView2(number: i, path: $path)
                }
        }
    }
}

// MARK: How to save NavigationStack paths using Codable
struct DetailRandomView: View {
    var number: Int

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }

        path = NavigationPath()
    }

    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}


struct NavigationStackPathsCodable: View {
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailRandomView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailRandomView(number: i)
                }
        }
    }
}

#Preview {
    NavigationStackPathsCodable()
}
