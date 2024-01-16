//
//  FileManagerError.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 16/10/2023.
//

import Foundation

enum FileManagerError: Error, LocalizedError {
    case readError
    case decodingError
    case encodingError
    case saveError
// TODO: Agregar
//    var errorDescription: String? {
//        switch self {
//        case .readError:
//            return NSLocalizedString("Could not load \(fileName).If the error persist, please reinstall the app", comment: "")
//        case .decodingError:
    //            return NSLocalizedString("There was a problem loading the data. If the error persist, please reinstall the app", comment: "")//
//        case .encodingError:
    //            return NSLocalizedString("Could not save your data. If the error persist, please reinstall the app", comment: "")
//        case .saveError:
    //            return NSLocalizedString("Could not save your data, if the error persist, please reinstall the app", comment: "")
//        }
//    }
    
}
