//
//  SampleConcurrencyApp.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

@main
struct SampleConcurrencyApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        UITableView.appearance().backgroundColor = UIColor.systemBackground
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     persistenceController.container.viewContext)
        }
    }
}
