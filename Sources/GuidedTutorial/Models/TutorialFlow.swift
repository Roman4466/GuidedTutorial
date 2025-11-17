//
//  TutorialFlow.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public struct TutorialFlow: Identifiable {
    public let id: UUID
    public let name: String
    public let steps: [TutorialStep]
    public let canBeSkipped: Bool
    public let skipGesture: SkipGesture?
    public let onComplete: (() -> Void)?
    public let onSkip: (() -> Void)?
    public let defaultTooltipStyle: TooltipStyle
    public let defaultBlurStyle: BlurStyle
    public let defaultArrowStyle: ArrowStyle
    public let validateAccessibility: Bool

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

        #if DEBUG
        if validateAccessibility {
            self.performAccessibilityValidation(defaultStyle: defaultTooltipStyle, steps: steps)
        }
        #endif
    }

    #if DEBUG
    private func performAccessibilityValidation(defaultStyle: TooltipStyle, steps: [TutorialStep]) {
        // Validate default style
        let defaultWarnings = AccessibilityHelpers.validateTooltipStyle(defaultStyle)
        if !defaultWarnings.isEmpty {
            print(" Accessibility Warning in '\(name)' default style:")
            defaultWarnings.forEach { print("  - \($0)") }
        }

        // Validate each step's custom style
        for (index, step) in steps.enumerated() {
            if let customStyle = step.tooltipStyle {
                let warnings = AccessibilityHelpers.validateTooltipStyle(customStyle)
                if !warnings.isEmpty {
                    print(" Accessibility Warning in '\(name)' step \(index + 1) (\(step.title)):")
                    warnings.forEach { print("  - \($0)") }
                }
            }
        }
    }
    #endif
}
