//
//  TooltipView.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct TooltipView: View {
    let step: TutorialStep
    let targetFrame: CGRect
    let screenSize: CGSize
    let onNext: () -> Void
    let onSkip: (() -> Void)?
    let tooltipStyle: TooltipStyle

    @State private var tooltipSize: CGSize = .zero
    @Environment(\.sizeCategory) var sizeCategory

    private var calculatedPosition: CGPoint {
        calculatePosition(tooltipSize: tooltipSize)
    }

    // Adjust max width based on accessibility text size
    private var maxTooltipWidth: CGFloat {
        switch sizeCategory {
        case .accessibilityMedium, .accessibilityLarge:
            return 400
        case .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            return 480
        default:
            return 320
        }
    }

    var body: some View {
        tooltipContent
            .accessibilityElement(children: .contain)
            .accessibilityLabel("\(step.title). \(step.description)")
            .accessibilityHint("Tutorial step. Use Next button to continue or Skip button to exit.")
            .padding(tooltipStyle.padding)
            .background(tooltipBackground)
            .frame(maxWidth: tooltipStyle.maxWidth ?? min(screenSize.width - (tooltipStyle.padding * 2), maxTooltipWidth))
            .overlay(
                GeometryReader { geo in
                    Color.clear.preference(key: SizePreferenceKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { size in
                tooltipSize = size
            }
            .position(calculatedPosition)
    }

    private var tooltipContent: some View {
        VStack(alignment: .leading, spacing: tooltipStyle.spacing) {
            Text(step.title)
                .font(tooltipStyle.titleFont)
                .foregroundColor(tooltipStyle.titleColor)
                .accessibilityAddTraits(.isHeader)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            Text(step.description)
                .font(tooltipStyle.descriptionFont)
                .foregroundColor(tooltipStyle.descriptionColor)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            if let customContent = step.customContent {
                customContent()
            }

            actionButtons
        }
    }

    private var actionButtons: some View {
        HStack {
            if onSkip != nil {
                Button("Skip") {
                    onSkip?()
                }
                .buttonStyle(.plain)
                .font(tooltipStyle.buttonFont)
                .foregroundColor(.secondary)
                .accessibilityLabel("Skip tutorial")
                .accessibilityHint("Exits the current tutorial")
            }

            Spacer()

            Button("Next") {
                onNext()
            }
            .font(tooltipStyle.buttonFont)
            .buttonStyle(.borderedProminent)
            .accessibilityLabel("Next step")
            .accessibilityHint("Continues to the next tutorial step")
        }
    }

    private var tooltipBackground: some View {
        RoundedRectangle(cornerRadius: tooltipStyle.cornerRadius)
            .fill(tooltipStyle.backgroundColor)
            .shadow(
                color: tooltipStyle.shadowColor.opacity(tooltipStyle.shadowOpacity),
                radius: tooltipStyle.shadowRadius,
                x: tooltipStyle.shadowX,
                y: tooltipStyle.shadowY
            )
    }

    private func calculatePosition(tooltipSize: CGSize) -> CGPoint {
        let defaultMaxWidth = tooltipStyle.maxWidth ?? min(screenSize.width - (tooltipStyle.padding * 2), maxTooltipWidth)
        let tooltipWidth = tooltipSize.width == 0 ? defaultMaxWidth : tooltipSize.width
        let tooltipHeight = tooltipSize.height == 0 ? 200 : tooltipSize.height
        let edgePadding = tooltipStyle.padding

        switch step.tooltipPosition {
        case .top(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, min(screenSize.width - tooltipWidth / 2 - edgePadding, targetFrame.midX)),
                y: max(tooltipHeight / 2 + edgePadding, yPos)
            )

        case .bottom(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, min(screenSize.width - tooltipWidth / 2 - edgePadding, targetFrame.midX)),
                y: min(screenSize.height - tooltipHeight / 2 - edgePadding, yPos)
            )

        case .leading(let offset):
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, xPos),
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight)
            )

        case .trailing(let offset):
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: min(screenSize.width - tooltipWidth / 2 - edgePadding, xPos),
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight)
            )

        case .topLeading(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            // Position tooltip with its top-right corner near target's top-left
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, min(screenSize.width - tooltipWidth / 2 - edgePadding, xPos)),
                y: max(tooltipHeight / 2 + edgePadding, yPos)
            )

        case .topTrailing(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            // Position tooltip with its top-left corner near target's top-right
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, min(screenSize.width - tooltipWidth / 2 - edgePadding, xPos)),
                y: max(tooltipHeight / 2 + edgePadding, yPos)
            )

        case .bottomLeading(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            // Position tooltip with its bottom-right corner near target's bottom-left
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, min(screenSize.width - tooltipWidth / 2 - edgePadding, xPos)),
                y: min(screenSize.height - tooltipHeight / 2 - edgePadding, yPos)
            )

        case .bottomTrailing(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            // Position tooltip with its bottom-left corner near target's bottom-right
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + edgePadding, min(screenSize.width - tooltipWidth / 2 - edgePadding, xPos)),
                y: min(screenSize.height - tooltipHeight / 2 - edgePadding, yPos)
            )

        case .center:
            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)

        case .automatic:
            return calculateAutomaticPosition(tooltipWidth: tooltipWidth, tooltipHeight: tooltipHeight, padding: edgePadding)
        }
    }

    private func calculateAutomaticPosition(tooltipWidth: CGFloat, tooltipHeight: CGFloat, padding ignored: CGFloat) -> CGPoint {
        let padding = tooltipStyle.padding
        let spaceAbove = targetFrame.minY
        let spaceBelow = screenSize.height - targetFrame.maxY
        let spaceLeft = targetFrame.minX
        let spaceRight = screenSize.width - targetFrame.maxX

        // Find the best position based on available space
        let positions = [
            (space: spaceBelow, position: CGPoint(
                x: clampX(targetFrame.midX, tooltipWidth: tooltipWidth),
                y: targetFrame.maxY + padding + tooltipHeight / 2
            )),
            (space: spaceAbove, position: CGPoint(
                x: clampX(targetFrame.midX, tooltipWidth: tooltipWidth),
                y: targetFrame.minY - padding - tooltipHeight / 2
            )),
            (space: spaceRight, position: CGPoint(
                x: targetFrame.maxX + padding + tooltipWidth / 2,
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight)
            )),
            (space: spaceLeft, position: CGPoint(
                x: targetFrame.minX - padding - tooltipWidth / 2,
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight)
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

    private func clampX(_ x: CGFloat, tooltipWidth: CGFloat) -> CGFloat {
        return max(tooltipWidth / 2 + tooltipStyle.padding, min(screenSize.width - tooltipWidth / 2 - tooltipStyle.padding, x))
    }

    private func clampY(_ y: CGFloat, tooltipHeight: CGFloat) -> CGFloat {
        return max(tooltipHeight / 2 + tooltipStyle.padding, min(screenSize.height - tooltipHeight / 2 - tooltipStyle.padding, y))
    }
}

// Helper for measuring tooltip size
private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
