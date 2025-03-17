//
// CustomStepperWithDescription.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct CustomStepperWithDescription: View {
    @Binding var value: Double
    @Binding var showDescription: Bool
    var label: String
    var range: ClosedRange<Double>
    var step: Double
    var description: String = ""
    var fractionLength: Int = 2

    var body: some View {
        WithDescriptionView(
            showDescription: $showDescription, description: description
        ) {
            Stepper {
                Text(label)
                Text(value, format: .number.precision(.fractionLength(fractionLength)))
            } onIncrement: {
                withAnimation {
                    value = min(value + step, range.upperBound)
                }
            } onDecrement: {
                withAnimation {
                    value = max(value - step, range.lowerBound)
                }
            }
        }
    }
}

#Preview {
    @Previewable
    @State var stepValue: Double = 30.0
    
    CustomStepperWithDescription(
        value: $stepValue,
        showDescription: .constant(true),
        label: "Label",
        range: 0...100,
        step: 1,
        description: ""
    )
}
