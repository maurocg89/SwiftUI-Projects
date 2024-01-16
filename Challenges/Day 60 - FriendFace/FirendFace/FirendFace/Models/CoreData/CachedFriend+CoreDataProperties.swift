//
//  CachedFriend+CoreDataProperties.swift
//  FirendFace
//
//  Created by Mauro Grillo on 24/07/2023.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    public var wrappedName: String {
        name ?? "Unkown Name"
    }

}

extension CachedFriend : Identifiable {

}
