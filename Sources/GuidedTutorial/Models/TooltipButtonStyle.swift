//
//  TooltipButtonStyle.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 15.11.2025.
//

import SwiftUI

public struct TooltipButtonStyle: Sendable {
    public let nextButtonText: String
    public let skipButtonText: String
    public let nextButtonColor: Color?
    public let skipButtonColor: Color?
    public let nextButtonStyle: ButtonStyleType
    public let skipButtonStyle: ButtonStyleType
    public let buttonSpacing: CGFloat
    public let buttonLayout: ButtonLayout
    public let customButtons: [CustomButton]?

    public init(
        nextButtonText: String = "Next",
        skipButtonText: String = "Skip",
        nextButtonColor: Color? = nil,
        skipButtonColor: Color? = nil,
        nextButtonStyle: ButtonStyleType = .borderedProminent,
        skipButtonStyle: ButtonStyleType = .plain,
        buttonSpacing: CGFloat = 12,
        buttonLayout: ButtonLayout = .horizontal,
        customButtons: [CustomButton]? = nil
    ) {
        self.nextButtonText = nextButtonText
        self.skipButtonText = skipButtonText
        self.nextButtonColor = nextButtonColor
        self.skipButtonColor = skipButtonColor
        self.nextButtonStyle = nextButtonStyle
        self.skipButtonStyle = skipButtonStyle
        self.buttonSpacing = buttonSpacing
        self.buttonLayout = buttonLayout
        self.customButtons = customButtons
    }

    public static let `default` = TooltipButtonStyle()
}

public enum ButtonStyleType: Sendable {
    case plain
    case bordered
    case borderedProminent
}

public enum ButtonLayout: Sendable {
    case horizontal
    case vertical
    case custom
}

public struct CustomButton: Sendable, Identifiable {
    public let id: UUID
    public let text: String
    public let action: @Sendable () -> Void
    public let color: Color?
    public let style: ButtonStyleType

    public init(
        id: UUID = UUID(),
        text: String,
        action: @Sendable @escaping () -> Void,
        color: Color? = nil,
        style: ButtonStyleType = .bordered
    ) {
        self.id = id
        self.text = text
        self.action = action
        self.color = color
        self.style = style
    }
}
