//
//  ValidateFormsView.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 03/07/2023.
//

import SwiftUI

struct ValidateFormsView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }

    var disableForm: Bool {
        username.count < 4 || email.count < 4
    }
}

struct ValidateFormsView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateFormsView()
    }
}
