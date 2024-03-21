//
//  TouchAndFaceIdPlaygroundView.swift
//  BucketList
//
//  Created by Mauro Grillo on 19/08/2023.
//

import LocalAuthentication
import SwiftUI

struct TouchAndFaceIdPlaygroundView: View {
    @State private var isUnlocked = false
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Touch ID usage description (Face ID usage description is added in project options)
            let reason = "We need your fingerprint to unlock your data"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    // authenticate successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct TouchAndFaceIdPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        TouchAndFaceIdPlaygroundView()
    }
}
