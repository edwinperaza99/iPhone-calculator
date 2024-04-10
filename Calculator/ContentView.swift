//
//  ContentView.swift
//  Calculator
//
//  Created by csuftitan on 3/13/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    var textColor: Color
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 35, weight: .heavy).bold())
            .frame(width: 90, height: 90)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}


struct ButtonModifier2: ViewModifier {
    var textColor: Color
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 35, weight: .heavy).bold())
            .padding(.leading, 35)
            .frame(width: 185, height: 80, alignment: .leading)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .clipShape(.capsule)
    }
    
}


struct ContentView: View {
//    constant for color of darker buttons
    let darkGray = Color(red: 55/255, green: 55/255, blue: 55/255)
    
//    variables for calculator functionality
    @State private var currentValue = "0"
    @State private var previousValue: Double? = nil
    @State private var operation: String? = nil

    
//    function to handle all buttons
    func handleButtonPressed(value: String) {
        switch value {
        case "AC":
            currentValue = "0"
            previousValue = nil
            operation = nil
        case "+/-":
            if let valueInDouble = Double(currentValue) {
                currentValue = String(valueInDouble * -1)
            }
        case "%":
            if let valueInDouble = Double(currentValue) {
                currentValue = String(valueInDouble * 0.01)
            }
        case "/", "x", "-", "+":
       if let valueInDouble = Double(currentValue) {
            if let prevValue = previousValue, let op = operation {
                // Perform the calculation for the previous operation
                switch op {
                case "+":
                    currentValue = String(prevValue + valueInDouble)
                    
                case "-":
                    currentValue = String(prevValue - valueInDouble)
                case "x":
                    currentValue = String(prevValue * valueInDouble)
                case "/":
                    currentValue = String(prevValue / valueInDouble)
                default:
                    break
                }
                previousValue = Double(currentValue)
            } else {
                // If there is no previous operation, update previousValue and operation
                previousValue = valueInDouble
                operation = value
                currentValue = "0"
            }
        }
        case "=":
            if let valueInDouble = Double(currentValue) {
                switch operation{
                case "+":
                    if let previousValue {
                        currentValue = String(valueInDouble + previousValue)
                    }
                    previousValue = Double(currentValue)
                case "-":
                    if let previousValue {
                        currentValue = String(previousValue - valueInDouble)
                    }
                    previousValue = Double(currentValue)
                case "x":
                    if let previousValue {
                        currentValue = String(valueInDouble * previousValue)
                    }
                    previousValue = Double(currentValue)
                case "/":
                    if let previousValue {
                        
                        currentValue = String(previousValue / valueInDouble)
                    }
                    previousValue = Double(currentValue)
                default:
                    print("error")
                }
                
            }
        default:
            if currentValue == "0" || currentValue == "0.0" {
                currentValue = value
            } else {
                if let currentDouble = Double(currentValue + value), let prevValue = previousValue, let op = operation {
                    // Check if an operation was performed previously
                    switch op {
                    case "+", "-", "x", "/":
                        // If an operation was performed, reset currentValue with the pressed number
                        currentValue = value
                        previousValue = currentDouble
                    default:
                        // If no operation was performed previously, append the pressed number to currentValue
                        currentValue += value
                    }
                } else {
                    // If no previous operation was performed, append the pressed number to currentValue
                    currentValue += value
                }
            }
        }
        
        
    }
    
    
    var body: some View {
        ZStack  {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text(currentValue.contains(".0") ? String(currentValue.dropLast(2)) : currentValue)
                    .font(.system(size: 90))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                HStack {
                    Button("AC") {
                        handleButtonPressed(value: "AC")
                    }
                    .modifier(ButtonModifier(textColor: .black, backgroundColor: .gray))
                    Button("+/-") {
                        handleButtonPressed(value: "+/-")
                    }
                    .modifier(ButtonModifier(textColor: .black, backgroundColor: .gray))
                    
                    Button("%") {
                        handleButtonPressed(value: "%")
                    }
                    .modifier(ButtonModifier(textColor: .black, backgroundColor: .gray))
                    Button("/") {
                        handleButtonPressed(value: "/")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: .orange))
                }
                HStack {
                    Button("7") {
                        handleButtonPressed(value: "7")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("8") {
                        handleButtonPressed(value: "8")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("9") {
                        handleButtonPressed(value: "9")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("x") {
                        handleButtonPressed(value: "x")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: .orange))
                }
                HStack {
                    Button("4") {
                        handleButtonPressed(value: "4")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("5") {
                        handleButtonPressed(value: "5")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("6") {
                        handleButtonPressed(value: "6")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("-") {
                        handleButtonPressed(value: "-")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: .orange))
                }
                HStack {
                    Button("1") {
                        handleButtonPressed(value: "1")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("2") {
                        handleButtonPressed(value: "2")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("3") {
                        handleButtonPressed(value: "3")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("+") {
                        handleButtonPressed(value: "+")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: .orange))
                }
                HStack {
                    Button("0") {
                        handleButtonPressed(value: "0")
                    }
                    .modifier(ButtonModifier2(textColor: .white, backgroundColor: darkGray))
                    Button(".") {
                        handleButtonPressed(value: ".")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: darkGray))
                    Button("=") {
                        handleButtonPressed(value: "=")
                    }
                    .modifier(ButtonModifier(textColor: .white, backgroundColor: .orange))
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
