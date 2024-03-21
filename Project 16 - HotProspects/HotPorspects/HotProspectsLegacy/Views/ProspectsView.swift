//
//  ProspectsView.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 03/01/2024.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortedType: String {
        case recent = "More Recent", name
    }

    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var sortedBy: SortedType = .recent
    @State private var isShowingSortOptionSheet = false
    let filter: FilterType

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Order by: ")
                        .font(.title3)
                    +
                    Text(sortedBy.rawValue.capitalized)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingSortOptionSheet = true
                    }, label: {
                        Label("", systemImage: "arrow.up.arrow.down")
                    })
                    .foregroundStyle(.primary)
                    .font(.title3)
                }
                .padding()

                List {
                    ForEach(filteredProspects) { prospect in
                        HStack(alignment: .center) {
                            if filter == .none {
                                Image(systemName: prospect.isContacted ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(prospect.isContacted ? .green : .red)
                                    .padding(.trailing)
                            }

                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAddress)
                                    .foregroundStyle(.secondary)
                            }

                        }
                        .swipeActions {
                            swipeActions(prospect: prospect)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\ntwostraws@gmail.com", completion: handleScan)
            }
            .confirmationDialog("Order By", isPresented: $isShowingSortOptionSheet, titleVisibility: .visible) {
                Button {
                    sortedBy = .name
                } label: {
                    Text("Name")
                }

                Button {
                    sortedBy = .recent
                } label: {
                    Text("More Recent")
                }
            }
        }
    }

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people.sorted(by: sortProspects)
        case .contacted:
            return prospects.people.filter { $0.isContacted }
                .sorted(by: sortProspects)
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
                .sorted(by: sortProspects)
        }
    }

    private func sortProspects(_ prospect1: Prospect, _ prospect2: Prospect) -> Bool {
        if sortedBy == .name {
          return prospect1.name < prospect2.name
        }
        return true
    }

    @ViewBuilder
    private func swipeActions(prospect: Prospect) -> some View {
        if prospect.isContacted {
            Group {
                Button {
                    prospects.toggle(prospect)
                } label: {
                    Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                }
                .tint(.red)
            }
        } else {
            Group {
                Button {
                prospects.toggle(prospect)
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

    private func handleScan(results: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch results {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let failure):
            print("Scanning Failed: \(failure.localizedDescription)")
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

            // For testing
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

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
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
