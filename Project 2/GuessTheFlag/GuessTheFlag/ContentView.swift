//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mauro Grillo on 09/04/2023.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitleStyle() -> some View {
        modifier(Title())
    }
}

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var questionsCount = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var flagTapped = 0
    @State private var isFlagTapped = false
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
//            RadialGradient(stops: [
//                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
//                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
//            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .prominentTitleStyle()
//                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped = number
                            isFlagTapped = true
                            flagTapped(number)
                            withAnimation(.interpolatingSpring(stiffness: 3, damping: 3)) {
                                animationAmount += 360
                            }
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .rotation3DEffect(.degrees(flagTapped == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(isFlagTapped && flagTapped != number ? 0.25 : 1.0)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionsCount == 8 {
                Button("Reset the game", action: resetGame)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            Text(questionsCount != 8 ? "Your score is \(totalScore)" : "Your final score is: \(totalScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                totalScore += 1
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])"
            }
            questionsCount += 1
            showingScore = true
        }
    }
    
    func askQuestion() {
        isFlagTapped = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        questionsCount = 0
        totalScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
