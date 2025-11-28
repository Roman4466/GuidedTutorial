//
//  TutorialFlow.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

/// Represents a complete tutorial flow containing multiple steps.
///
/// A `TutorialFlow` defines the sequence of steps, default styles,
/// and callbacks for a guided tutorial experience.
///
/// ## Example
/// ```swift
/// let flow = TutorialFlow(
///     name: "Onboarding",
///     steps: [step1, step2, step3],
///     canBeSkipped: true,
///     skipGesture: .swipeDown,
///     onComplete: { print("Done!") }
/// )
/// coordinator.startFlow(flow)
/// ```
public struct TutorialFlow: Identifiable {
    /// Unique identifier for the flow
    public let id: UUID
    /// Name of the tutorial flow
    public let name: String
    /// Array of tutorial steps in order
    public let steps: [TutorialStep]
    /// Whether users can skip the tutorial
    public let canBeSkipped: Bool
    /// Gesture to skip the entire tutorial
    public let skipGesture: SkipGesture?
    /// Callback when tutorial completes
    public let onComplete: (() -> Void)?
    /// Callback when tutorial is skipped
    public let onSkip: (() -> Void)?
    /// Default tooltip style for all steps
    public let defaultTooltipStyle: TooltipStyle
    /// Default blur style for all steps
    public let defaultBlurStyle: BlurStyle
    /// Default arrow style for all steps
    public let defaultArrowStyle: ArrowStyle
    /// Whether to validate accessibility in DEBUG builds
    public let validateAccessibility: Bool

    /// Creates a new tutorial flow
    public init(
        id: UUID = UUID(),
        name: String,
        steps: [TutorialStep],
        canBeSkipped: Bool = true,
        skipGesture: SkipGesture? = .swipeDown,
        onComplete: (() -> Void)? = nil,
        onSkip: (() -> Void)? = nil,
        defaultTooltipStyle: TooltipStyle = .default,
        defaultBlurStyle: BlurStyle = .default,
        defaultArrowStyle: ArrowStyle = .default,
        validateAccessibility: Bool = true
    ) {
        self.id = id
        self.name = name
        self.steps = steps
        self.canBeSkipped = canBeSkipped
        self.skipGesture = skipGesture
        self.onComplete = onComplete
        self.onSkip = onSkip
        self.defaultTooltipStyle = defaultTooltipStyle
        self.defaultBlurStyle = defaultBlurStyle
        self.defaultArrowStyle = defaultArrowStyle
        self.validateAccessibility = validateAccessibility
    }
}
