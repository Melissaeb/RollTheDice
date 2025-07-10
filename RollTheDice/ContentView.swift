//
//  ContentView.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 08/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var diceRolled: Bool = false
    @State private var totalD4s: Int = 0
    @State private var totalD6s: Int = 0
    @State private var totalD8s: Int = 0
    @State private var totalD10s: Int = 0
    @State private var totalD12s: Int = 0
    @State private var totalD20s: Int = 0
    @State private var totalD100s: Int = 0
    private let range: ClosedRange<Int> = 0...5
    
    @State private var d4Rolls: [Int] = []
    @State private var d6Rolls: [Int] = []
    @State private var d8Rolls: [Int] = []
    @State private var d10Rolls: [Int] = []
    @State private var d12Rolls: [Int] = []
    @State private var d20Rolls: [Int] = []
    @State private var d100Rolls: [Int] = []
    private var total: Int {
        d4Rolls.reduce(0, +) + d6Rolls.reduce(0, +) + d8Rolls.reduce(0, +) + d10Rolls.reduce(0, +) + d12Rolls.reduce(0, +) + d20Rolls.reduce(0, +) + d100Rolls.reduce(0, +)
    }
    
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
                    Button("ROLL", action: rollDice)
                        .frame(width: 120, height: 40)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .padding(.trailing, 56)
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
    
    func rollDice() {
        d4Rolls.removeAll()
        d6Rolls.removeAll()
        d8Rolls.removeAll()
        d10Rolls.removeAll()
        d12Rolls.removeAll()
        d20Rolls.removeAll()
        d100Rolls.removeAll()
        
        if self.totalD4s > 0 {
            for _ in 1...self.totalD4s {
                d4Rolls.append(Int.random(in: 1...4))
            }
        }
        if self.totalD6s > 0 {
            for _ in 1...self.totalD6s {
                d6Rolls.append(Int.random(in: 1...6))
            }
        }
        if self.totalD8s > 0 {
            for _ in 1...self.totalD8s {
                d8Rolls.append(Int.random(in: 1...8))
            }
        }
        if self.totalD10s > 0 {
            for _ in 1...self.totalD10s {
                d10Rolls.append(Int.random(in: 1...10))
            }
        }
        if self.totalD12s > 0 {
            for _ in 1...self.totalD12s {
                d12Rolls.append(Int.random(in: 1...12))
            }
        }
        if self.totalD20s > 0 {
            for _ in 1...self.totalD20s {
                d20Rolls.append(Int.random(in: 1...20))
            }
        }
        if self.totalD100s > 0 {
            for _ in 1...self.totalD100s {
                d100Rolls.append(Int.random(in: 1...100))
            }
        }
        diceRolled = true
    }
}

#Preview {
    ContentView()
}



