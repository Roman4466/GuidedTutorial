//
//  ArrowStyle.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.11.2025.
//

import SwiftUI

public struct ArrowStyle: Sendable {
    public let color: Color
    public let lineWidth: CGFloat
    public let arrowheadLength: CGFloat
    public let arrowheadAngle: CGFloat
    public let animationDuration: Double
    public let animationEnabled: Bool
    public let curveIntensity: CGFloat
    public let customArrowView: (@Sendable (CGPoint, CGPoint) -> AnyView)?

    public init(
        color: Color = .blue,
        lineWidth: CGFloat = 3,
        arrowheadLength: CGFloat = 10,
        arrowheadAngle: CGFloat = 30,
        animationDuration: Double = 0.6,
        animationEnabled: Bool = true,
        curveIntensity: CGFloat = 1.0,
        customArrowView: (@Sendable (CGPoint, CGPoint) -> AnyView)? = nil
    ) {
        self.color = color
        self.lineWidth = lineWidth
        self.arrowheadLength = arrowheadLength
        self.arrowheadAngle = arrowheadAngle
        self.animationDuration = animationDuration
        self.animationEnabled = animationEnabled
        self.curveIntensity = curveIntensity
        self.customArrowView = customArrowView
    }

    public static let `default` = ArrowStyle()
}
