//
//  CachedUser+CoreDataProperties.swift
//  FirendFace
//
//  Created by Mauro Grillo on 24/07/2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var formattedDate: String?
    @NSManaged public var friends: NSSet?

    var wrappedName: String {
        name ?? "Unkown Name"
    }

    var wrappedCompany: String {
        company ?? "Unkown Company"
    }

    var wrappedAddress: String {
        address ?? "Unkown Address"
    }

    var wrappedEmail: String {
        email ?? "Unknown Email"
    }

    var wrappedAbout: String {
        about ?? "Unkown About"
    }

    var wrappedId: String {
        id ?? UUID().uuidString
    }

    var wrappedFormattedDate: String {
        formattedDate ?? "Unknown Date"
    }

    public var friendArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }

    var userInitials: String {
        let nameComponents = self.wrappedName.components(separatedBy: .whitespaces)
        return "\(nameComponents.first?.first ?? " ")\(nameComponents.last?.first ?? " ")"
    }

}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
