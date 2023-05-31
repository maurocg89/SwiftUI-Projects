//
//  ContentView.swift
//  Edutainment
//
//  Created by Mauro Grillo on 26/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var questionsNumber = 5
    @State private var questionsCount = 0
    @State private var gameStarted = false
    @State private var score = 0
    @State private var question = ""
    @State private var answer = ""
    @State private var correctAnswer = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Section("Select the multiplication table you want to practice") {
                        //                        Stepper("\(multiplicationTable)", value: $multiplicationTable, in: 2...12, step: 1)
                        Picker("", selection: $multiplicationTable) {
                            ForEach(2..<13, id: \.self) {
                                Text($0.formatted())
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                    }
                    
                    Section("Select how many questions do you want") {
                        Stepper("\(questionsNumber)", value: $questionsNumber, in: 5...15, step: 5)
                            .padding(.bottom)
                    }
                    
                    if !gameStarted {
                        CustomButton(buttonAction: {
                            withAnimation {
                                gameStarted.toggle()
                            }
                            askQuestion()
                        }, buttonText: "Start")
                    }
                    
                    if gameStarted {
                        Group {
                            Text("What is \(question)?")
                                .font(.headline)
                            TextField("Answer", text: $answer)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .padding(.bottom)
                            CustomButton(buttonAction: {
                                checkAnswer()
                            }, buttonText: "Enter")
                        }
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
            .navigationTitle("Edutainment")
            .alert(alertTitle, isPresented: $showAlert) {
                if questionsCount != questionsNumber {
                    Button("Continue", action: askQuestion)
                } else {
                    Button("Finish", action: restart)
                }
            } message: {
                if questionsCount == questionsNumber {
                    Text("Your final score was: \(score)")
                }
            }
        }
    }
    
    func askQuestion() {
        let number = Int.random(in: 2...12)
        question = "\(multiplicationTable) x \(number)"
        correctAnswer = String(multiplicationTable * number)
        questionsCount += 1
    }
    
    func checkAnswer() {
        guard !answer.isEmpty else {
            return
        }
        if correctAnswer == answer {
            alertTitle = "Correct Answer!"
            score += 1
        } else {
            alertTitle = "Wrong Answer! The correct answer was: \(correctAnswer)"
        }
        answer = ""
        showAlert = true
    }
    
    func restart() {
        gameStarted = false
        questionsCount = 0
        score = 0
    }
    
}

struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        modifier(ButtonPress(onPress: onPress, onRelease: onRelease))
    }
}

struct CustomButton: View {
    @State private var isButtonPressed = false
    
    var buttonAction: () -> Void
    var buttonText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(.black.opacity(0.5))
                .frame(width: 100, height: 40)
            Text(buttonText)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .opacity(isButtonPressed ? 0.7 : 1)
        .scaleEffect(isButtonPressed ? 1.1 : 1)
        .pressEvents {
            withAnimation(.easeIn(duration: 0.1)) {
                isButtonPressed = true
            }
        } onRelease: {
            withAnimation {
                isButtonPressed = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    buttonAction()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
