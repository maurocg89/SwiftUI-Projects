//
//  FileManagerPlaygroundView.swift
//  BucketList
//
//  Created by Mauro Grillo on 17/08/2023.
//

import SwiftUI

struct FileManagerPlaygroundView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                do {
                    // Atomic writing causes the system to write our full file to a temporary filename (not the one we asked for), and when that’s finished it does a simple rename to our target filename. This means either the whole file is there or nothing is.
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }

    // URL of the documents directory for the user for our app only (sandbox)
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct FileManagerPlaygroundView2: View {
    @State private var showingAlert = false
    @State private var fileContent = ""
    let fileName = "test.txt"

    var body: some View {
        VStack {
            Button("Save File") {
                FileManager.default.saveFile(fileName, "Hello World!")
            }
            .buttonStyle(.borderedProminent)
            .tint(.mint)

            Button("Load File") {
                fileContent = FileManager.default.getFile(fileName)
                showingAlert = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(fileContent), dismissButton: .default(Text("OK")))
        }

    }
}


struct FileManagerPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerPlaygroundView2()
    }
}
