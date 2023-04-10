//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by user236450 on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var questionCounter = 1
    
    var body: some View{
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                Spacer()
                Spacer()
                Text("Score \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCounter != 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: restartGame)
            }
        } message: {
            if questionCounter != 8 {
                Text("Your score is \(userScore)")
            } else {
                Text("You ended the game with a score of \(userScore). Press the restart button to restart the game.")
            }
        }
    }

    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong, this is flag of \(countries[number])"
        }
        
        showingScore = true
        
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter = 1
        userScore = 0
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
