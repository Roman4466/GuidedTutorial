//
//  TutorialStep.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

public struct TutorialStep: Identifiable {
    public let id: UUID
    public let targetKey: String
    public let title: String
    public let description: String
    public let highlightShape: HighlightShape
    public let actionType: ActionType
    public let tooltipPosition: TooltipPosition
    public let showArrow: Bool
    public let blockOtherInteractions: Bool
    public let customContent: (() -> AnyView)?
    public let tooltipStyle: TooltipStyle?
    public let blurStyle: BlurStyle?

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
        blurStyle: BlurStyle? = nil
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
    }
}
