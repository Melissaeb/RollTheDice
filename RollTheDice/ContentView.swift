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

struct DieType: Identifiable {
    let id = UUID()
    let sides: Int
    var count: Int
    var rolls: [Int]
}

struct ContentView: View {
    @State private var diceRolled: Bool = false
    private let range: ClosedRange<Int> = 0...5
    
    @State private var diceData: [DieType] = [
        DieType(sides: 4, count: 0, rolls: []),
        DieType(sides: 6, count: 0, rolls: []),
        DieType(sides: 8, count: 0, rolls: []),
        DieType(sides: 10, count: 0, rolls: []),
        DieType(sides: 12, count: 0, rolls: []),
        DieType(sides: 20, count: 0, rolls: []),
        DieType(sides: 100, count: 0, rolls: [])
    ]
    
    private var total: Int {
        diceData.flatMap { $0.rolls }.reduce(0, +)
    }
    
    @State private var savedTotal: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                ForEach($diceData) { $dieType in
                    DiceView(
                        number: 4,
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
