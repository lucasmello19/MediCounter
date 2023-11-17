//
//  MediCounterApp.swift
//  MediCounter
//
//  Created by Lucas Mello on 17/11/23.
//

import SwiftUI

@main
struct MediCounterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
