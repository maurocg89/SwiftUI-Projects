//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Mauro Grillo on 19/07/2023.
//

import CoreData
import SwiftUI

struct FilteredListView<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = !filterValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue)) : FetchRequest<T>(sortDescriptors: [])
        self.content = content
    }
}
