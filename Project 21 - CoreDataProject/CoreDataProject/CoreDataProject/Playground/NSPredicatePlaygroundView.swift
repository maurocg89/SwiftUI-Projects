//
//  NSPredicatePlaygroundView.swift
//  CoreDataProject
//
//  Created by Mauro Grillo on 18/07/2023.
//

import CoreData
import SwiftUI

struct NSPredicatePlaygroundView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    // Another predicate examples:
    // NSPrediicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"]
    // NSPredicate(format: "name < %@", "F")
    // NSPredicate(format: "name BEGINSWITH %@", "E") // case sensitive
    // NSPredicate(format: "name BEGINSWITH[c] %@", "e") // case insensitive
    // NSPredicate(format: "name CONTAINS %@", "E")
    // NSPredicate(format: "NOT name BEGINSWITH[c] %@", "E") 


    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: moc)
                ship3.name = "Millenium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? moc.save()

            }
        }
    }
}

struct NSPredicatePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        NSPredicatePlaygroundView()
    }
}
