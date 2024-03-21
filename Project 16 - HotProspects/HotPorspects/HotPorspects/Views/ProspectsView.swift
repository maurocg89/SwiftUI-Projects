//
//  ProspectsView.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 14/02/2024.
//

import CodeScanner
import SwiftData
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortedType: String {
        case recent = "More Recent", name
    }

    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]

    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()

    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
    }

    var body: some View {
        NavigationStack {
            List(prospects, selection: $selectedProspects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)

                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                .swipeActions {
                    swipeActions(prospect: prospect)
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\ntwostraws@gmail.com", completion: handleScan)
        }
    }

    init(filter: FilterType) {
        self.filter = filter
        let showContactedOnly = filter == .contacted

        _prospects = Query(filter: #Predicate {
            $0.isContacted == showContactedOnly
        }, sort: [SortDescriptor(\Prospect.name)])
    }

    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            modelContext.insert(person)

        case .failure(let failure):
            print("Scanning Failed: \(failure.localizedDescription)")
        }
    }

    private func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    private func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print(error?.localizedDescription ?? "Error")
                    }
                }
            }
        }
    }

    private func swipeActions(prospect: Prospect) -> some View {
        Group {
            Button("Delete", systemImage: "trash", role: .destructive) {
                modelContext.delete(prospect)
            }

            if prospect.isContacted {
                Button {
                    prospect.isContacted.toggle()
                } label: {
                    Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                }
                .tint(.red)
            } else {
                Button {
                    prospect.isContacted.toggle()
                } label: {
                    Label("Mark Uncontacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                }
                .tint(.green)

                Button {
                    addNotification(for: prospect)
                } label: {
                    Label("Remind me", systemImage: "bell")
                }
                .tint(.orange)
            }
        }
    }

}

#Preview {
    ProspectsView(filter: .contacted)
}
