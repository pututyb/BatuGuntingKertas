//
//  ContentView.swift
//  BatuGuntingKertas
//
//  Created by Putut Yusri Bahtiar on 13/01/23.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "✌️"]
    
    @State private var score = 0
    @State private var questionCount = 0
    @State private var showingResults = false
    
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Gunting Batu Kertas")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Computer:")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(moves[computerChoice])
                    .font(.system(size: 150))
                
                if shouldWin {
                    Text("Whic one win ?")
                        .foregroundColor(.green)
                        .font(.title)
                } else {
                    Text("Which one lose ?")
                        .foregroundColor(.red)
                        .font(.title)
                }
                
                HStack {
                    ForEach(0..<3) { number in
                        Button(moves[number]) {
                            play(choice: number)
                            
                        }
                        .font(.system(size: 80))
                        .alert("Game Over", isPresented: $showingResults) {
                            Button("Play again", action: reset)
                        } message: {
                            Text("Your score was \(score)")
                        }
                    }
                }
                Spacer()
                
                Text("Score: \(score)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 3 {
            showingResults = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
    }
    
    func reset() {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
