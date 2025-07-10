//
//  ContentView.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 08/07/2025.
//

import SwiftUI

// TODO: Add SwiftData to store previous rolls
// TODO: Have sheet slide in from the side with previous rolls
// TODO: Add accessibility elements

struct ContentView: View {
    @State private var diceRolled: Bool = false
    private let range: ClosedRange<Int> = 0...5
    
    @State private var totalD4s: Int = 0
    @State private var totalD6s: Int = 0
    @State private var totalD8s: Int = 0
    @State private var totalD10s: Int = 0
    @State private var totalD12s: Int = 0
    @State private var totalD20s: Int = 0
    @State private var totalD100s: Int = 0
    
    @State private var d4Rolls: [Int] = []
    @State private var d6Rolls: [Int] = []
    @State private var d8Rolls: [Int] = []
    @State private var d10Rolls: [Int] = []
    @State private var d12Rolls: [Int] = []
    @State private var d20Rolls: [Int] = []
    @State private var d100Rolls: [Int] = []
    
    private var total: Int {
        d4Rolls.reduce(0, +) +
        d6Rolls.reduce(0, +) +
        d8Rolls.reduce(0, +) +
        d10Rolls.reduce(0, +) +
        d12Rolls.reduce(0, +) +
        d20Rolls.reduce(0, +) +
        d100Rolls.reduce(0, +)
    }
    @State private var savedTotal: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                DiceView(number: 4, totalDice: $totalD4s, range: range, diceRolls: $d4Rolls, diceRolled: $diceRolled)
                DiceView(number: 6, totalDice: $totalD6s, range: range, diceRolls: $d6Rolls, diceRolled: $diceRolled)
                DiceView(number: 8, totalDice: $totalD8s, range: range, diceRolls: $d8Rolls, diceRolled: $diceRolled)
                DiceView(number: 10, totalDice: $totalD10s, range: range, diceRolls: $d10Rolls, diceRolled: $diceRolled)
                DiceView(number: 12, totalDice: $totalD12s, range: range, diceRolls: $d12Rolls, diceRolled: $diceRolled)
                DiceView(number: 20, totalDice: $totalD20s, range: range, diceRolls: $d20Rolls, diceRolled: $diceRolled)
                DiceView(number: 100, totalDice: $totalD100s, range: range, diceRolls: $d100Rolls, diceRolled: $diceRolled)
                
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

                    
                    Text("Total: ")
                        .font(.title)
                        .frame(width: 70)
                    Text("\(total)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .frame(width: 70, height: 40)
                        .background(Color.pink)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.bottom, 24)
            }
            .padding(.top, 16)
            .navigationTitle("Roll the Dice")
        }
    }
    
    private func rollDice() async {
        let delays: [Double] = [0.02, 0.04, 0.06, 0.08, 0.1, 0.15, 0.2, 0.3]

        setDiceRolls()
        for delay in delays {
            try? await Task.sleep(for: .seconds(delay))
            setDiceRolls()
        }
        savedTotal = total
    }
    
    private func setDiceRolls() {
        rollSpecificDie(count: totalD4s, sides: 4, into: &d4Rolls)
        rollSpecificDie(count: totalD6s, sides: 6, into: &d6Rolls)
        rollSpecificDie(count: totalD8s, sides: 8, into: &d8Rolls)
        rollSpecificDie(count: totalD10s, sides: 10, into: &d10Rolls)
        rollSpecificDie(count: totalD12s, sides: 12, into: &d12Rolls)
        rollSpecificDie(count: totalD20s, sides: 20, into: &d20Rolls)
        rollSpecificDie(count: totalD100s, sides: 100, into: &d100Rolls)
        
        diceRolled = true
    }

    private func rollSpecificDie(count: Int, sides: Int, into rolls: inout [Int]) {
        rolls.removeAll()
        if count > 0 {
            for _ in 1...count {
                rolls.append(Int.random(in: 1...sides))
            }
        }
    }
}

#Preview {
    ContentView()
}



