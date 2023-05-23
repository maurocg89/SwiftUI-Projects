//
//  ContentView.swift
//  UnitConversions
//
//  Created by Mauro Grillo on 09/04/2023.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var inputFocusState: Bool
    @State private var inputNumberString = ""
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Farenheit"
    
    
    var result: Double {
        guard let inputNumber = Double(inputNumberString) else { return 0.0 }
        // Celsius
        if inputUnit == tempUnits[0] {
            switch outputUnit {
            case "Farenheit":
                return celsiusToFarenheit(inputNumber)
            case "Kelvin":
                return celsiusToKelvin(inputNumber)
            default:
                return inputNumber
            }
        // Farenheit
        } else if inputUnit == tempUnits[1] {
            switch outputUnit {
            case "Celsius":
                return farenheitToCelsius(inputNumber)
            case "Kelvin":
                return farenheitToKelvin(inputNumber)
            default:
                return inputNumber
            }
        // Kelvin
        } else {
            switch outputUnit {
            case "Celsius":
                return kelvinToCelsius(inputNumber)
            case "Farenheit":
                return kelvinToFarenheit(inputNumber)
            default:
                return inputNumber
            }
        }

    }
    
    let tempUnits = ["Celsius", "Farenheit", "Kelvin"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("From", selection: $inputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("To", selection: $outputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    
                } header: {
                    Text("Temperature Conversion")
                }
                
                Section {
                    TextField("Temperature", text: $inputNumberString)
                        .keyboardType(.decimalPad)
                        .focused($inputFocusState)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Text(inputNumberString != "" ? "\(result, specifier: "%.1f")" : "")
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Units Conversions")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputFocusState = false
                    }
                }
            }
        }
    }
    
    func celsiusToKelvin(_ input: Double) -> Double {
        return input + 273
    }
    
    func kelvinToCelsius(_ input: Double) -> Double {
        return input - 273
    }
    
    func celsiusToFarenheit(_ input: Double) -> Double {
        return (9 * input) / 5 + 32
    }
    func farenheitToCelsius(_ input: Double) -> Double {
        return 5 * (input - 32) / 9
    }
    func kelvinToFarenheit(_ input: Double) -> Double {
        9 * (input - 273) / 5 + 32
    }
    func farenheitToKelvin(_ input: Double) -> Double {
        5 * (input - 32) / 9 + 273
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
