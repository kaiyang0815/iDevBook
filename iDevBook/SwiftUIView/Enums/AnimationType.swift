//
// AnimationType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum AnimationType: String, CaseIterable, Identifiable {
    case `default`
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case bouncy
    case smooth
    case snappy
    case spring
    case interactiveSpring
    case custom

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .default:
            "Default"
        case .linear:
            "Linear"
        case .easeIn:
            "Ease In"
        case .easeOut:
            "Ease Out"
        case .easeInOut:
            "Ease In Out"
        case .bouncy:
            "Bouncy"
        case .smooth:
            "Smooth"
        case .snappy:
            "Snappy"
        case .spring:
            "Spring"
        case .interactiveSpring:
            "Interactive Spring"
        case .custom:
            "Custom"
        }
    }

    var description: String {
        switch self {
        case .default:
            "A default animation instance."
        case .linear:
            "An animation that moves at a constant speed."
        case .easeIn:
            "An animation that starts slowly and then increases speed towards the end of the movement."
        case .easeOut:
            "An animation that starts quickly and then slows towards the end of the movement."
        case .easeInOut:
            "An animation that combines the behaviors of in and out easing animations."
        case .bouncy:
            "A spring animation with a predefined duration and higher amount of bounce that can be tuned."
        case .smooth:
            "A smooth spring animation with a predefined duration and no bounce that can be tuned."
        case .snappy:
            "A spring animation with a predefined duration and small amount of bounce that feels more snappy and can be tuned."
        case .spring:
            "A persistent spring animation. When mixed with other spring() or interactiveSpring() animations on the same property, each animation will be replaced by their successor, preserving velocity from one animation to the next. Optionally blends the response values between springs over a time period."
        case .interactiveSpring:
            "An interpolating spring animation that uses a damped spring model to produce values in the range [0, 1] that are then used to interpolate within the [from, to] range of the animated property. Preserves velocity across overlapping animations by adding the effects of each animation."
        case .custom:
            ""
        }
    }
}
