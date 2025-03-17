//
// Temp.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct Temp: View {
    @State private var stepperStep: Double = 1
    var body: some View {
        Form {
            Section {
                Stepper {
                    Text("Stepper step")
                    Text(stepperStep, format: .number)
                } onIncrement: {
                    stepperStep += 1
                    if stepperStep >= 10 { stepperStep = 10 }
                } onDecrement: {
                    stepperStep -= 1
                    if stepperStep < 0 { stepperStep = 0 }
                }
                CustomStepperWithDescription(
                    value: $stepperStep, showDescription: .constant(true),
                    label: "Stepper step", range: 0...10, step: 1, fractionLength: 0)
            }
        }
    }
}

#Preview {
    Temp()
}
