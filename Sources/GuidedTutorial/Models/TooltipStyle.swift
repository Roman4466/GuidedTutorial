//
//  TooltipStyle.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI

public struct TooltipStyle: Sendable {
    public let backgroundColor: Color
    public let cornerRadius: CGFloat
    public let shadowColor: Color
    public let shadowOpacity: Double
    public let shadowRadius: CGFloat
    public let shadowX: CGFloat
    public let shadowY: CGFloat
    public let maxWidth: CGFloat?
    public let titleFont: Font
    public let titleColor: Color
    public let descriptionFont: Font
    public let descriptionColor: Color
    public let buttonFont: Font
    public let padding: CGFloat
    public let spacing: CGFloat

    public init(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 12,
        shadowColor: Color = .black,
        shadowOpacity: Double = 0.2,
        shadowRadius: CGFloat = 10,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 5,
        maxWidth: CGFloat? = nil,
        titleFont: Font = .headline,
        titleColor: Color = .primary,
        descriptionFont: Font = .body,
        descriptionColor: Color = .secondary,
        buttonFont: Font = .body,
        padding: CGFloat = 16,
        spacing: CGFloat = 12
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.maxWidth = maxWidth
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.descriptionFont = descriptionFont
        self.descriptionColor = descriptionColor
        self.buttonFont = buttonFont
        self.padding = padding
        self.spacing = spacing
    }

    public static let `default` = TooltipStyle()
}
