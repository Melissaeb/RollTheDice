//
//  ContentView.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 08/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var totalD4s: Int = 0
    @State private var totalD6s: Int = 0
    @State private var totalD8s: Int = 0
    @State private var totalD10s: Int = 0
    @State private var totalD12s: Int = 0
    @State private var totalD20s: Int = 0
    @State private var totalD100s: Int = 0
    private let range: ClosedRange<Int> = 0...5
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HStack {
                    DiceView(number: 4, value: $totalD4s, range: range)
                    ForEach(range.lowerBound..<totalD4s + 1, id: \.self) { total in
                        if total > 0 {
                            Text("\(total)")
                        }
                    }
                }
                DiceView(number: 6, value: $totalD6s, range: range)
                DiceView(number: 8, value: $totalD8s, range: range)
                DiceView(number: 10, value: $totalD10s, range: range)
                DiceView(number: 12, value: $totalD12s, range: range)
                DiceView(number: 20, value: $totalD20s, range: range)
                DiceView(number: 100, value: $totalD100s, range: range)
            }
            HStack {
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


struct DiceView: View {
    let number: Int
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    var body: some View {
        VStack {
            Text("D\(number)")
                .fontWeight(.heavy)
                .font(.headline)
                .frame(width: 80, height: 40)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 4)
                    .fill(Color.red))
            HStack {
                Button {
                    if value > range.lowerBound {
                        value -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .resizable()
                        .frame(width: 12, height: 1.5)
                        .foregroundColor(value > range.lowerBound ? .primary.opacity(0.9) : .gray)
                        .frame(width: 20, height: 20)
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
                Text("\(value)")
                    .font(.caption)
                
                Button {
                    if value < 5 {
                        value += 1
                    }
                    print(value)
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(value < range.upperBound ? .primary.opacity(0.9) : .gray)
                        .frame(width: 20, height: 20)
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
        }
    }
}
