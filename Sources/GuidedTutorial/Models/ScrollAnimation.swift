//
//  ScrollAnimation.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 28.11.2025.
//

import SwiftUI

/// Defines the animation style for scrolling to tutorial targets
public enum ScrollAnimation: Sendable {
    /// Ease in and out animation (default)
    case easeInOut(duration: Double = 0.5)
    /// Ease in animation (slow start, fast end)
    case easeIn(duration: Double = 0.5)
    /// Ease out animation (fast start, slow end)
    case easeOut(duration: Double = 0.5)
    /// Linear animation (constant speed)
    case linear(duration: Double = 0.5)
    /// Spring animation with response and damping
    case spring(response: Double = 0.5, dampingFraction: Double = 0.8)
    /// Interpolating spring with stiffness and damping
    case interpolatingSpring(stiffness: Double = 170, damping: Double = 15)
    /// No animation
    case none

    /// Default scroll animation
    public static let `default` = ScrollAnimation.easeInOut(duration: 0.5)

    /// Creates a SwiftUI Animation from this ScrollAnimation
    public var animation: Animation? {
        switch self {
        case .easeInOut(let duration):
            return .easeInOut(duration: duration)
        case .easeIn(let duration):
            return .easeIn(duration: duration)
        case .easeOut(let duration):
            return .easeOut(duration: duration)
        case .linear(let duration):
            return .linear(duration: duration)
        case .spring(let response, let dampingFraction):
            return .spring(response: response, dampingFraction: dampingFraction)
        case .interpolatingSpring(let stiffness, let damping):
            return .interpolatingSpring(stiffness: stiffness, damping: damping)
        case .none:
            return nil
        }
    }
}
