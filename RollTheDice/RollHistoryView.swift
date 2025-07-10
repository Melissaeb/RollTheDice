//
//  RollHistoryView.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 11/07/2025.
//

import SwiftUI
import SwiftData

struct RollHistoryView: View {
    @Environment(\.dismiss) var dismiss
    var diceHistory: DiceHistory

    var body: some View {
        NavigationView {
            VStack {
                if diceHistory.rolls.isEmpty {
                    ContentUnavailableView("No Rolls Yet", systemImage: "dice.fill", description: Text("Roll some dice to see your history here!"))
                        .accessibilityLabel("No roll history available.")
                } else {
                    List {
                        ForEach(diceHistory.rolls.sorted(by: { $0.timeStamp > $1.timeStamp })) { roll in
                            HStack {
                                Text("\(roll.total)")
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Roll total \(roll.total))")
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Roll History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                    .accessibilityLabel("Dismiss History")
                    .accessibilityHint("Closes the roll history sheet.")
                }
            }
        }
    }
}
