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

    public init(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 12,
        shadowColor: Color = .black,
        shadowOpacity: Double = 0.2,
        shadowRadius: CGFloat = 10,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 5,
        maxWidth: CGFloat? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.maxWidth = maxWidth
    }

    public static let `default` = TooltipStyle()
}
