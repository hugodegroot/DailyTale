//
//  TalesController.swift
//  DailyTale
//
//  Created by Hugo de Groot on 12/08/2023.
//

import CoreData
import SwiftUI

class TalesController: ObservableObject {
    let container = NSPersistentContainer(name: "DailyTale")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                // TODO: handle error
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
