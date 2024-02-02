//
//  ChallengeView.swift
//  CoreDataProject
//
//  Created by Mauro Grillo on 19/07/2023.
//

import SwiftUI

enum Predicate: String, CaseIterable, Identifiable, CustomStringConvertible {
    case beginsWithCaseSensitive = "BEGINSWITH"
    case beginsWith = "BEGINSWITH[c]"
    case containsCaseSensitive = "CONTAINS"
    case contains = "CONTAINS[c]"
    var id: Self { self }
//    case predicateIn = "IN"

    var description: String {
        switch self {
        case .beginsWithCaseSensitive:
            return "Begins With (case sensitive)"
        case .beginsWith:
            return "Begins With"
        case .containsCaseSensitive:
            return "Contains (case sensitive)"
        case .contains:
            return "Contains"
        }
    }
}

struct ChallengeView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var filterValue = ""
    @State private var filterKeys = ["First Name", "Last Name"]
    @State private var selectedFilterKey = "" {
        didSet {
            filterKey = selectedFilterKey == "First Name" ? "firstName" : "lastName"
        }
    }
    @State private var filterKey = "firstName"
    @State private var selectedPredicate: Predicate = .beginsWith
//    @State private var selectedSortedBy = "name"

    var body: some View {
        VStack {
            FilteredListView(filterKey: filterKey, filterValue: filterValue, predicate: selectedPredicate, sortDescriptors: [
                SortDescriptor<Singer>(\.firstName),
                SortDescriptor<Singer>(\.lastName)
            ]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            HStack {
                Text("Filter Key: ")
                Picker("Filter Keys", selection: $selectedFilterKey) {
                    ForEach(filterKeys, id: \.self) {
                        Text($0)
                    }
                }
            }

            HStack {
                Text("Predicate: ")
                Picker("Predicate", selection: $selectedPredicate) {
                    ForEach(Predicate.allCases) {
                        Text(String(describing: $0))
                    }
                }
            }

            TextField("Filter", text: $filterValue)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .frame(width: 220)
                .padding(.horizontal)

//            Button("Add Examples") {
//                let taylor = Singer(context: moc)
//                taylor.firstName = "Taylor"
//                taylor.lastName = "Swift"
//
//                let ed = Singer(context: moc)
//                ed.firstName = "Ed"
//                ed.lastName = "Sheeran"
//
//                let adele = Singer(context: moc)
//                adele.firstName = "Adele"
//                adele.lastName = "Adkins"
//
//                try? moc.save()
//            }
        }

    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
