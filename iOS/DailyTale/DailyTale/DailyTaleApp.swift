//
//  DailyTaleApp.swift
//  DailyTale
//
//  Created by Hugo de Groot on 04/08/2023.
//

import SwiftUI

@main
struct DailyTaleApp: App {
    @StateObject private var talesController = TalesController()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, talesController.container.viewContext)
        }
    }
}
