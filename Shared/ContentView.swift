//
//  ContentView.swift
//  Shared
//
//  Created by Jinwook Kim on 2021/12/30.
//

import SwiftUI

struct ContentView: View {
    @State private var score: Int = 0
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var countries: [String] = ["France", "Germany", "Ireland", "Italy", "Estonia", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var stage: Int = 0
    @State private var isGameOver: Bool = false
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Text("Stage \(stage)")
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Text(countries[number])
                                .foregroundColor(.primary)
                        }
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    }
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            .padding(30)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Countinue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("Game Over", isPresented: $isGameOver) {
                Button("Reset", action: resetGame)
            } message: {
                Text("Your final score is \(score)")
            }
        }
    }
    func flagTapped(_ number: Int) -> Void {
        stage += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
        if stage >= 8 {
            isGameOver = true
        }
    }
    func askQuestion() -> Void {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame() -> Void {
        askQuestion()
        stage = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
