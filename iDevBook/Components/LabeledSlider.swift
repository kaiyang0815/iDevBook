//
//  LabeledSlider.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/18.
//
//

import SwiftUI

struct LabeledSlider<T: BinaryFloatingPoint>: View
where T.Stride: BinaryFloatingPoint {
    var title: String
    @Binding var value: T
    var range: ClosedRange<T>
    var step: T.Stride = 1

    var body: some View {
        LabeledContent {
            Slider(value: $value, in: range, step: step) {
                Text(title)
            } minimumValueLabel: {
                Text("\(range.lowerBound)")
            } maximumValueLabel: {
                Text("\(range.upperBound)")
            }
        } label: {
            Text(title)
        }
    }
}

#Preview {
    @Previewable
    @State var sliderValue: CGFloat = 1
    Form {
        Section {
            LabeledSlider(title: "Labeled", value: $sliderValue, range: 0...100, step: 1)
        }
    }
}
