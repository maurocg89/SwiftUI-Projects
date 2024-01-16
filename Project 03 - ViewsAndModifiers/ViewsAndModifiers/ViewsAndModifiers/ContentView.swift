//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Mauro Grillo on 09/04/2023.
//

import SwiftUI

// MARK: CUSTOM CONTAINERS
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

// MARK: CUSTOM MODIFIERS
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .backgroundStyle(.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

// MARK: VIEW COMPOSITION
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var agreedToEmails = false
    
    var body: some View {
        // MARK: CUSTOM BINDING
        let agreedToAll = Binding<Bool>(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            })
        ScrollView {
            VStack {
                Group {
                    Toggle("Agree to terms", isOn: $agreedToTerms)
                    Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
                    Toggle("Agree to emails", isOn: $agreedToEmails)
                    Toggle("Agree to all", isOn: agreedToAll)
                }
                .padding(.horizontal, 10)
                
                CapsuleText(text: "First")
                    .foregroundColor(.white)
                CapsuleText(text: "Second")
                    .foregroundColor(.yellow)
                Text("Hello World")
                    .modifier(Title())
                Text("Hello World")
                    .titleStyle()
                Color.blue
                    .frame(width: 200, height: 200)
                    .watermarked(with: "Watermark")
                GridStack(rows: 4, columns: 4) { row, column in
                    HStack {
                        Image(systemName: "\(row * 4 + column).circle")
                        Text("R\(row) C\(column)")
                    }
                }
                VStack {
                    Text("Title")
                    // font is an environment modifier, so override the VStack font
                    Text("Subtitle")
                        .font(.subheadline)
                        .blur(radius: 0)
                }
                // ENVIRONMENT MODIFIER
                .font(.title)
                // REGULAR MODIFIER (can't be override by a child)
                .blur(radius: 5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
