//
//  UserWrapper.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import Foundation
import SwiftUI

class UserListWrapper: ObservableObject {
    @Published var userList = [User]()
}
