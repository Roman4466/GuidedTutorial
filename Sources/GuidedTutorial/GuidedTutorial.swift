//
//  GuidedTutorial.swift
//  GuidedTutorial
//
//  A SwiftUI framework for creating interactive guided tutorials.
//

import SwiftUI

/// GuidedTutorial is a SwiftUI framework for creating interactive onboarding experiences
/// and guided tutorials for iOS applications.
///
/// ## Overview
///
/// GuidedTutorial provides a complete solution for:
/// - Highlighting UI elements with customizable spotlight overlays
/// - Displaying informative tooltips with various positioning options
/// - Supporting multiple interaction types (tap, swipe, long press, etc.)
/// - Automatic scrolling to tutorial targets
/// - Full customization of styles, colors, and animations
///
/// ## Getting Started
///
/// 1. Create a `TutorialCoordinator`:
/// ```swift
/// @StateObject private var coordinator = TutorialCoordinator()
/// ```
///
/// 2. Mark UI elements as tutorial targets:
/// ```swift
/// Button("Start") { }
///     .tutorialTarget("startButton", coordinator: coordinator)
/// ```
///
/// 3. Add the tutorial overlay:
/// ```swift
/// ContentView()
///     .tutorialOverlay(coordinator: coordinator)
/// ```
///
/// 4. Define and start a tutorial flow:
/// ```swift
/// let flow = TutorialFlow(
///     name: "Onboarding",
///     steps: [/* your steps */],
///     canBeSkipped: true
/// )
/// coordinator.startFlow(flow)
/// ```
///
/// ## Key Components
///
/// - `TutorialCoordinator`: Manages tutorial state and progression
/// - `TutorialFlow`: Defines a sequence of tutorial steps
/// - `TutorialStep`: Configures individual tutorial steps
/// - `TooltipStyle`: Customizes tooltip appearance
/// - `ArrowStyle`: Customizes arrow indicators
/// - `BlurStyle`: Customizes background blur
///
/// For more information, see the README and online documentation.
public struct GuidedTutorial {
    // This type serves as the framework's main documentation entry point
}
