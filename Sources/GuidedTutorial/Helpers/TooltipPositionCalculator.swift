//
//  TooltipPositionCalculator.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 17.11.2025.
//

import SwiftUI

/// Centralized calculator for tooltip positioning to ensure consistency
/// between arrow placement and actual tooltip rendering
struct TooltipPositionCalculator {

    /// Calculates the tooltip position based on the step configuration
    /// - Parameters:
    ///   - tooltipPosition: The desired position relative to target
    ///   - targetFrame: The frame of the highlighted element
    ///   - screenSize: The size of the screen
    ///   - tooltipSize: The size of the tooltip (can be estimated or actual)
    ///   - tooltipStyle: The tooltip style containing padding and other configs
    /// - Returns: The calculated center point for the tooltip
    static func calculatePosition(
        tooltipPosition: TooltipPosition,
        targetFrame: CGRect,
        screenSize: CGSize,
        tooltipSize: CGSize,
        tooltipStyle: TooltipStyle
    ) -> CGPoint {
        let tooltipWidth = tooltipSize.width
        let tooltipHeight = tooltipSize.height
        let edgePadding = tooltipStyle.padding

        switch tooltipPosition {
        case .top(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            return CGPoint(
                x: clampX(targetFrame.midX, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: edgePadding),
                y: max(tooltipHeight / 2 + edgePadding, yPos)
            )

        case .bottom(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            return CGPoint(
                x: clampX(targetFrame.midX, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: edgePadding),
                y: min(screenSize.height - tooltipHeight / 2 - edgePadding, yPos)
            )

        case .leading(let offset):
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, xPos),
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight, screenSize: screenSize, padding: edgePadding)
            )

        case .trailing(let offset):
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: min(screenSize.width - tooltipWidth / 2 - edgePadding, xPos),
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight, screenSize: screenSize, padding: edgePadding)
            )

        case .topLeading(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: clampX(xPos, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: edgePadding),
                y: max(tooltipHeight / 2 + edgePadding, yPos)
            )

        case .topTrailing(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: clampX(xPos, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: edgePadding),
                y: max(tooltipHeight / 2 + edgePadding, yPos)
            )

        case .bottomLeading(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: clampX(xPos, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: edgePadding),
                y: min(screenSize.height - tooltipHeight / 2 - edgePadding, yPos)
            )

        case .bottomTrailing(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: clampX(xPos, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: edgePadding),
                y: min(screenSize.height - tooltipHeight / 2 - edgePadding, yPos)
            )

        case .center:
            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)

        case .automatic:
            return calculateAutomaticPosition(
                targetFrame: targetFrame,
                screenSize: screenSize,
                tooltipWidth: tooltipWidth,
                tooltipHeight: tooltipHeight,
                padding: edgePadding
            )
        }
    }

    /// Calculates the best automatic position based on available space
    private static func calculateAutomaticPosition(
        targetFrame: CGRect,
        screenSize: CGSize,
        tooltipWidth: CGFloat,
        tooltipHeight: CGFloat,
        padding: CGFloat
    ) -> CGPoint {
        let spaceAbove = targetFrame.minY
        let spaceBelow = screenSize.height - targetFrame.maxY
        let spaceLeft = targetFrame.minX
        let spaceRight = screenSize.width - targetFrame.maxX

        // Find the best position based on available space
        let positions = [
            (space: spaceBelow, position: CGPoint(
                x: clampX(targetFrame.midX, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: padding),
                y: targetFrame.maxY + padding + tooltipHeight / 2
            )),
            (space: spaceAbove, position: CGPoint(
                x: clampX(targetFrame.midX, tooltipWidth: tooltipWidth, screenSize: screenSize, padding: padding),
                y: targetFrame.minY - padding - tooltipHeight / 2
            )),
            (space: spaceRight, position: CGPoint(
                x: targetFrame.maxX + padding + tooltipWidth / 2,
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight, screenSize: screenSize, padding: padding)
            )),
            (space: spaceLeft, position: CGPoint(
                x: targetFrame.minX - padding - tooltipWidth / 2,
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight, screenSize: screenSize, padding: padding)
            ))
        ]

        // Choose the position with the most space
        if let bestPosition = positions.max(by: { $0.space < $1.space })?.position {
            // Ensure the position is within screen bounds
            let clampedX = max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, bestPosition.x))
            let clampedY = max(tooltipHeight / 2 + padding, min(screenSize.height - tooltipHeight / 2 - padding, bestPosition.y))
            return CGPoint(x: clampedX, y: clampedY)
        }

        // Fallback to center if no good position found
        return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
    }

    /// Clamps X coordinate to keep tooltip on screen
    private static func clampX(_ x: CGFloat, tooltipWidth: CGFloat, screenSize: CGSize, padding: CGFloat) -> CGFloat {
        return max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, x))
    }

    /// Clamps Y coordinate to keep tooltip on screen
    private static func clampY(_ y: CGFloat, tooltipHeight: CGFloat, screenSize: CGSize, padding: CGFloat) -> CGFloat {
        return max(tooltipHeight / 2 + padding, min(screenSize.height - tooltipHeight / 2 - padding, y))
    }
}
