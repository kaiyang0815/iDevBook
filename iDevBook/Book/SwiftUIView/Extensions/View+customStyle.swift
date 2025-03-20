//
// File.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

extension View {
    func customButtonStyle(_ styleType: CustomButtonStyleType) -> some View {
        switch styleType {
        case .automatic:
            return AnyView(self.buttonStyle(DefaultButtonStyle()))
        case .bordered:
            return AnyView(self.buttonStyle(BorderedButtonStyle()))
        case .borderedProminent:
            return AnyView(self.buttonStyle(BorderedProminentButtonStyle()))
        case .plain:
            return AnyView(self.buttonStyle(PlainButtonStyle()))
        case .borderless:
            return AnyView(self.buttonStyle(BorderlessButtonStyle()))
        }
    }
}

extension View {
    func switchPickerStyle(_ styleType: PickerStyleType) -> some View {
        switch styleType {
        case .automatic:
            return AnyView(self.pickerStyle(.automatic))
        case .inline:
            return AnyView(self.pickerStyle(.inline))
        case .menu:
            return AnyView(self.pickerStyle(.menu))
        case .navigationLink:
            return AnyView(self.pickerStyle(.navigationLink))
        case .palette:
            return AnyView(self.pickerStyle(.palette))
        case .radioGroup:
            #if os(macOS)
                return AnyView(self.pickerStyle(.radioGroup))
            #else
                return AnyView(self.pickerStyle(.automatic))
            #endif
        case .segmented:
            return AnyView(self.pickerStyle(.segmented))
        case .wheel:
            #if os(iOS)
                return AnyView(self.pickerStyle(.wheel))
            #else
                return AnyView(self.pickerStyle(.automatic))
            #endif
        }
    }
}

extension View {
    func switchDatePickerStyle(_ styleType: DatePickerStyleType) -> some View {
        switch styleType {
        case .automatic:
            return AnyView(self.datePickerStyle(.automatic))
        case .compact:
            return AnyView(self.datePickerStyle(.compact))
        case .field:
            #if os(macOS)
                return AnyView(self.datePickerStyle(.field))
            #else
                return AnyView(self.datePickerStyle(.automatic))
            #endif
        case .graphical:
            return AnyView(self.datePickerStyle(.graphical))
        case .stepperField:
            #if os(macOS)
                return AnyView(self.datePickerStyle(.stepperField))
            #else
                return AnyView(self.datePickerStyle(.automatic))
            #endif
        case .wheel:
            return AnyView(self.datePickerStyle(.wheel))
        }

    }
}

extension View {
    func switchGaugeStyle(_ styleType: GaugeStyleType) -> some View {
        switch styleType {
        case .automatic:
            return AnyView(self.gaugeStyle(.automatic))
        case .circular:
            #if os(watchOS)
                return AnyView(self.gaugeStyle(.circular))
            #else
                return AnyView(self.gaugeStyle(.automatic))
            #endif

        case .linear:

            #if os(watchOS)
                return AnyView(self.gaugeStyle(.linear))
            #else
                return AnyView(self.gaugeStyle(.automatic))
            #endif
        }
    }
}

extension View {
    func switchProgressViewStyle(_ styleType: ProgressViewStyleType)
        -> some View
    {
        switch styleType {
        case .automatic:
            return AnyView(self.progressViewStyle(.automatic))
        case .circular:
            return AnyView(self.progressViewStyle(.circular))
        case .linear:
            return AnyView(self.progressViewStyle(.linear))
        }
    }
}
