//
//  GesturePlaygroundView.swift
//  Moonshot
//
//  Created by Mauro Grillo on 16/05/2023.
//

import SwiftUI

struct GesturePlaygroundView: View {
    var body: some View {
        ScrollView() {
            ForEach(0..<5, id: \.self) { i in
               ListElem()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ListElem: View {
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @GestureState var isTapping = false
    
    var body: some View {
        // Gets triggered immediately because a drag of 0 distance starts already when touching down.
        let tapGesture = DragGesture(minimumDistance: 0)
            .updating($isTapping) {_, isTapping, _ in
                isTapping = true
            }
        
        // minimumDistance here is mainly relevant to change to red before the drag
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged { offset = $0.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture(minimumDuration: 1.0)
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // The dragGesture will wait until the pressGesture has triggered after minimumDuration 1.0 seconds.
        let combined = pressGesture.sequenced(before: dragGesture)
        
        // The new combined gesture is set to run together with the tapGesture.
        let simultaneously = tapGesture.simultaneously(with: combined)
        
        return Circle()
            .overlay(isTapping ? Circle().stroke(Color.red, lineWidth: 5) : nil) //listening to the isTapping state
            .frame(width: 100, height: 100)
            .foregroundColor(isDragging ? Color.red : Color.black) // listening to the isDragging state.
            .offset(offset)
            .gesture(simultaneously)
    }
}

struct GesturePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        GesturePlaygroundView()
    }
}
