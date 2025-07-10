//
//  RollTheDiceApp.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 08/07/2025.
//

import SwiftData
import SwiftUI

@main
struct RollTheDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [DiceHistory.self, LastChosenDice.self])
    }
}
