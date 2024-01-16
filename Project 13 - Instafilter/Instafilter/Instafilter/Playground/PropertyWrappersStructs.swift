//
//  PropertyWrappersStructs.swift
//  Instafilter
//
//  Created by Mauro Grillo on 28/07/2023.
//

import SwiftUI

// Property wrappers have that name because they wrap our property inside another struct. What this means is that when we use @State to wrap a string, the actual type of property we end up with is a State<String>. Similarly, when we use @Environment and others we end up with a struct of type Environment that contains some other value inside it.

// If we inspect the State property wrraper we see:
// @propertyWrapper public struct State<Value> : DynamicProperty {}
// That @propertyWrapper attribute is what makes this into @State for us to use.
//
// A few lines further down, we see this:
// public var wrappedValue: Value { get nonmutating set }
// That wrapped value is the actual value we’re trying to store, such as a string. What this generated interface is telling us is that the property can be read (get), and written (set), but that when we set the value it won’t actually change the struct itself. Behind the scenes, it sends that value off to SwiftUI for storage in a place where it can be modified freely, so it’s true that the struct itself never changes.

struct PropertyWrappersStructs: View {
    // State wraps its value using a non-mutating setter, which means neither blurAmount or the State struct wrapping it are changing – our binding is directly changing the internally stored value, which means the property observer is never being triggered.
    // So, changing the property directly using a button works fine, because it goes through the nonmutating setter and triggers the didSet observer, but using a binding doesn’t because it bypasses the setter and adjusts the value directly.
    // To fix this we need to use the onChange() modifier, which tells SwiftUI to run a function of our choosing when a particular value changes
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is: \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { newValue in
                    print("New value from onChange is: \(newValue)")
                }

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

struct PropertyWrappersStructs_Previews: PreviewProvider {
    static var previews: some View {
        PropertyWrappersStructs()
    }
}
