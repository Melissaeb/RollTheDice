//
//  DiceView.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 10/07/2025.
//

import SwiftUI

struct DiceView: View {
    let number: Int
    @Binding var totalDice: Int
    let range: ClosedRange<Int>
    @Binding var diceRolls: [Int]
    @Binding var diceRolled: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Text("D\(number)")
                    .fontWeight(.heavy)
                    .frame(width: 60, height: 40)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.red))
                    .padding(0)
                
                VStack {
                    Button {
                        if totalDice < range.upperBound {
                            totalDice += 1
                            diceRolled = false
                        }
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(totalDice < range.upperBound ? .primary.opacity(0.9) : .gray)
                            .frame(width: 24, height: 24)
                            .background(Color.secondary.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: totalDice)
                    
                    Button {
                        if totalDice > range.lowerBound {
                            totalDice -= 1
                            diceRolled = false
                        }
                    } label: {
                        Image(systemName: "minus")
                            .resizable()
                            .frame(width: 12, height: 1.5)
                            .foregroundColor(totalDice > range.lowerBound ? .primary.opacity(0.9) : .gray)
                            .frame(width: 24, height: 24)
                            .background(Color.secondary.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: totalDice)
                }
            }
            .padding(.leading)
            
            HStack {
                ForEach(0..<totalDice, id: \.self) { index in
                    Text(diceRolled && index < diceRolls.count ? "\(diceRolls[index])" : "\(number)")
                        .fontWeight(.heavy)
                        .frame(width: 40, height: 40)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing)
        }
    }
}
