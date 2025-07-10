//
//  ContentView.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 08/07/2025.
//

import SwiftData
import SwiftUI

struct DieType: Identifiable, Codable {
    let id = UUID()
    let sides: Int
    var count: Int
    var rolls: [Int]
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var diceHistoryRecords: [DiceHistory]
    @Query var lastChosenDiceRecords: [LastChosenDice]
    
    @State private var diceRolled: Bool = false
    private let range: ClosedRange<Int> = 0...5
    
    @State private var diceData: [DieType]
    
    private var total: Int {
        diceData.flatMap { $0.rolls }.reduce(0, +)
    }
    
    @State private var savedTotal: Int = 0
    @State private var showingHistorySheet: Bool = false
    
    init() {
        _diceData = State(initialValue: [])
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    ForEach($diceData) { $dieType in
                        DiceView(
                            number: dieType.sides,
                            totalDice: $dieType.count,
                            range: range,
                            diceRolls: $dieType.rolls,
                            diceRolled: $diceRolled
                        )
                    }
                    
                    HStack {
                        Button {
                            Task {
                                await rollDice()
                            }
                        } label: {
                            Text("ROLL")
                                .frame(width: 120, height: 40)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .padding(.trailing, 56)
                        }
                        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: total)
                        .accessibilityLabel("Roll Dice")
                        .accessibilityHint("Activates the dice roll and updates the total.")
                        
                        Text("Total: ")
                            .font(.title)
                            .frame(width: 70)
                            .accessibilityHidden(true)
                        
                        Text("\(total)")
                            .font(.title)
                            .fontWeight(.heavy)
                            .frame(width: 70, height: 40)
                            .background(Color.pink)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .accessibilityLabel("Current total")
                            .accessibilityValue("\(total)")
                    }
                    .padding(.bottom, 24)
                }
                .padding(.top, 16)
            }
            .navigationTitle("Roll the Dice")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingHistorySheet = true
                    } label: {
                        Label("Show History", systemImage: "list.bullet.clipboard.fill")
                    }
                    .accessibilityLabel("View Roll History")
                    .accessibilityHint("Opens a sheet displaying all previous dice roll totals.")
                }
            }
            .sheet(isPresented: $showingHistorySheet) {
                RollHistoryView(diceHistory: diceHistoryRecords.first ?? DiceHistory())
            }
        }
        .onAppear {
            loadInitialDiceData()
        }
    }
    
    private func loadInitialDiceData() {
        
        let defaultDiceTypes: [DieType] = [
            DieType(sides: 4, count: 0, rolls: []),
            DieType(sides: 6, count: 0, rolls: []),
            DieType(sides: 8, count: 0, rolls: []),
            DieType(sides: 10, count: 0, rolls: []),
            DieType(sides: 12, count: 0, rolls: []),
            DieType(sides: 20, count: 0, rolls: []),
            DieType(sides: 100, count: 0, rolls: [])
        ]
        
        if let lastChosen = lastChosenDiceRecords.first {
            var loadedDiceData: [DieType] = []
            for (sides, count) in lastChosen.chosenDiceCounts {
                loadedDiceData.append(DieType(sides: sides, count: count, rolls: []))
            }
            
            loadedDiceData.sort { $0.sides < $1.sides }
            var mergedDiceData = defaultDiceTypes
            for i in mergedDiceData.indices {
                if let loadedDie = loadedDiceData.first(where: { $0.sides == mergedDiceData[i].sides }) {
                    mergedDiceData[i].count = loadedDie.count
                }
            }
            diceData = mergedDiceData
        } else {
            diceData = defaultDiceTypes
        }
    }
    
    private func rollDice() async {
        let delays: [Double] = [0.03, 0.05, 0.07, 0.09, 0.1, 0.15, 0.2, 0.3, 0.4]

        setDiceRolls()
        for delay in delays {
            try? await Task.sleep(for: .seconds(delay))
            setDiceRolls()
        }
        savedTotal = total
        
        let newRoll = DiceRoll(total: savedTotal, timeStamp: Date())
                if let history = diceHistoryRecords.first {
                    history.rolls.append(newRoll)
                } else {
                    let newHistory = DiceHistory(rolls: [newRoll])
                    modelContext.insert(newHistory)
                }

                var currentChosenDice: [Int: Int] = [:]
                for die in diceData {
                    currentChosenDice[die.sides] = die.count
                }

                if let lastChosen = lastChosenDiceRecords.first {
                    lastChosen.chosenDiceCounts = currentChosenDice
                } else {
                    let newLastChosen = LastChosenDice(chosenDiceCounts: currentChosenDice)
                    modelContext.insert(newLastChosen)
                }

                do {
                    try modelContext.save()
                    print("Successfully saved roll and chosen dice to SwiftData.")
                } catch {
                    print("Failed to save to SwiftData: \(error.localizedDescription)")
                }
        
        UIAccessibility.post(notification: .announcement, argument: "Dice rolled. New total is \(total).")
    }
    
    private func setDiceRolls() {
        for i in diceData.indices {
            let sides = diceData[i].sides
            let count = diceData[i].count
            
            let newRolls = (0..<count).map { _ in Int.random(in: 1...sides) }
            diceData[i].rolls = newRolls
        }
        
        diceRolled = true
    }
}

#Preview {
    ContentView()
}
