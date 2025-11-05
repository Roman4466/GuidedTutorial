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

    @State private var tooltipSize: CGSize = .zero

    private var calculatedPosition: CGPoint {
        calculatePosition(tooltipSize: tooltipSize)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(step.title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(step.description)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            if let customContent = step.customContent {
                customContent()
            }

            HStack {
                if onSkip != nil {
                    Button("Skip") {
                        onSkip?()
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.secondary)
                }

                Spacer()

                Button("Next") {
                    onNext()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .frame(maxWidth: min(screenSize.width - 32, 320))
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

    private func calculatePosition(tooltipSize: CGSize) -> CGPoint {
        let tooltipWidth = tooltipSize.width == 0 ? min(screenSize.width - 32, 320) : tooltipSize.width
        let tooltipHeight = tooltipSize.height == 0 ? 200 : tooltipSize.height
        let padding: CGFloat = 16

        switch step.tooltipPosition {
        case .top(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, targetFrame.midX)),
                y: max(tooltipHeight / 2 + padding, yPos)
            )

        case .bottom(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, targetFrame.midX)),
                y: min(screenSize.height - tooltipHeight / 2 - padding, yPos)
            )

        case .leading(let offset):
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, xPos),
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight)
            )

        case .trailing(let offset):
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: min(screenSize.width - tooltipWidth / 2 - padding, xPos),
                y: clampY(targetFrame.midY, tooltipHeight: tooltipHeight)
            )

        case .topLeading(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            // Position tooltip with its top-right corner near target's top-left
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: max(tooltipHeight / 2 + padding, yPos)
            )

        case .topTrailing(let offset):
            let yPos = targetFrame.minY - offset - tooltipHeight / 2
            // Position tooltip with its top-left corner near target's top-right
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: max(tooltipHeight / 2 + padding, yPos)
            )

        case .bottomLeading(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            // Position tooltip with its bottom-right corner near target's bottom-left
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: min(screenSize.height - tooltipHeight / 2 - padding, yPos)
            )

        case .bottomTrailing(let offset):
            let yPos = targetFrame.maxY + offset + tooltipHeight / 2
            // Position tooltip with its bottom-left corner near target's bottom-right
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: min(screenSize.height - tooltipHeight / 2 - padding, yPos)
            )

        case .center:
            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)

        case .automatic:
            return calculateAutomaticPosition(tooltipWidth: tooltipWidth, tooltipHeight: tooltipHeight, padding: padding)
        }
    }

    private func calculateAutomaticPosition(tooltipWidth: CGFloat, tooltipHeight: CGFloat, padding: CGFloat) -> CGPoint {
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
        let padding: CGFloat = 16
        return max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, x))
    }

    private func clampY(_ y: CGFloat, tooltipHeight: CGFloat) -> CGFloat {
        let padding: CGFloat = 16
        return max(tooltipHeight / 2 + padding, min(screenSize.height - tooltipHeight / 2 - padding, y))
    }
}

// Helper for measuring tooltip size
private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
