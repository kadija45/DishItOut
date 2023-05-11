//
//  DishItOutApp.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/18/23.
//

import SwiftUI
import Firebase



@main
@available(iOS 16.0, *)
struct DishItOut: App {
    // register app delegate for Firebase setup
    init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }


    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthenticationModel())
        }
    }
}
