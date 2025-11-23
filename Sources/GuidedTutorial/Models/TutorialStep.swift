//
//  TutorialStep.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

/// Represents a single step in a tutorial flow.
///
/// Each step defines what element to highlight, what tooltip to show,
/// and how the user should interact to proceed.
///
/// ## Example
/// ```swift
/// TutorialStep(
///     targetKey: "myButton",
///     title: "Welcome",
///     description: "Tap this button to get started.",
///     highlightShape: .circle,
///     tooltipPosition: .bottom(offset: 10)
/// )
/// ```
public struct TutorialStep: Identifiable {
    /// Unique identifier for the step
    public let id: UUID
    /// Key matching the view's `.tutorialTarget()` modifier
    public let targetKey: String
    /// Title displayed in the tooltip
    public let title: String
    /// Description text displayed in the tooltip
    public let description: String
    /// Shape used to highlight the target element
    public let highlightShape: HighlightShape
    /// The action required to advance to the next step
    public let actionType: ActionType
    /// Position of the tooltip relative to the target
    public let tooltipPosition: TooltipPosition
    /// Whether to show an arrow pointing to the target
    public let showArrow: Bool
    /// Whether to block interactions with other UI elements
    public let blockOtherInteractions: Bool
    /// Optional custom content to display in the tooltip
    public let customContent: (() -> AnyView)?
    /// Custom tooltip style for this step
    public let tooltipStyle: TooltipStyle?
    /// Custom blur style for this step
    public let blurStyle: BlurStyle?
    /// Custom arrow style for this step
    public let arrowStyle: ArrowStyle?

    /// Creates a new tutorial step
    /// - Parameters:
    ///   - id: Unique identifier (auto-generated if not provided)
    ///   - targetKey: Key matching the view's `.tutorialTarget()` modifier
    ///   - title: Title displayed in the tooltip
    ///   - description: Description text displayed in the tooltip
    ///   - highlightShape: Shape used to highlight the target element
    ///   - actionType: The action required to advance to the next step
    ///   - tooltipPosition: Position of the tooltip relative to the target
    ///   - showArrow: Whether to show an arrow pointing to the target
    ///   - blockOtherInteractions: Whether to block interactions with other UI elements
    ///   - customContent: Optional custom content to display in the tooltip
    ///   - tooltipStyle: Custom tooltip style for this step
    ///   - blurStyle: Custom blur style for this step
    ///   - arrowStyle: Custom arrow style for this step
    public init(
        id: UUID = UUID(),
        targetKey: String,
        title: String,
        description: String,
        highlightShape: HighlightShape = .rectangle(),
        actionType: ActionType = .tap,
        tooltipPosition: TooltipPosition = .automatic,
        showArrow: Bool = true,
        blockOtherInteractions: Bool = true,
        customContent: (() -> AnyView)? = nil,
        tooltipStyle: TooltipStyle? = nil,
        blurStyle: BlurStyle? = nil,
        arrowStyle: ArrowStyle? = nil
    ) {
        self.id = id
        self.targetKey = targetKey
        self.title = title
        self.description = description
        self.highlightShape = highlightShape
        self.actionType = actionType
        self.tooltipPosition = tooltipPosition
        self.showArrow = showArrow
        self.blockOtherInteractions = blockOtherInteractions
        self.customContent = customContent
        self.tooltipStyle = tooltipStyle
        self.blurStyle = blurStyle
        self.arrowStyle = arrowStyle
    }
}
