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

    @State private var calculatedPosition: CGPoint = .zero

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
        .position(calculatedPosition)
        .onAppear {
            calculatedPosition = calculatePosition()
        }
        .onChange(of: targetFrame) { _ in
            calculatedPosition = calculatePosition()
        }
    }

    private func calculatePosition() -> CGPoint {
        let tooltipWidth: CGFloat = min(screenSize.width - 32, 320)
        let estimatedHeight: CGFloat = 200 // Approximate tooltip height

        switch step.tooltipPosition {
        case .top(let offset):
            return CGPoint(
                x: max(tooltipWidth / 2 + 16, min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.midX)),
                y: max(estimatedHeight / 2 + 16, targetFrame.minY - offset - estimatedHeight / 2)
            )

        case .bottom(let offset):
            return CGPoint(
                x: max(tooltipWidth / 2 + 16, min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.midX)),
                y: min(screenSize.height - estimatedHeight / 2 - 16, targetFrame.maxY + offset + estimatedHeight / 2)
            )

        case .leading(let offset):
            return CGPoint(
                x: max(tooltipWidth / 2 + 16, targetFrame.minX - offset - tooltipWidth / 2),
                y: targetFrame.midY
            )

        case .trailing(let offset):
            return CGPoint(
                x: min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.maxX + offset + tooltipWidth / 2),
                y: targetFrame.midY
            )

        case .topLeading(let offset):
            return CGPoint(
                x: max(tooltipWidth / 2 + 16, targetFrame.minX - offset),
                y: max(estimatedHeight / 2 + 16, targetFrame.minY - offset - estimatedHeight / 2)
            )

        case .topTrailing(let offset):
            return CGPoint(
                x: min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.maxX + offset),
                y: max(estimatedHeight / 2 + 16, targetFrame.minY - offset - estimatedHeight / 2)
            )

        case .bottomLeading(let offset):
            return CGPoint(
                x: max(tooltipWidth / 2 + 16, targetFrame.minX - offset),
                y: min(screenSize.height - estimatedHeight / 2 - 16, targetFrame.maxY + offset + estimatedHeight / 2)
            )

        case .bottomTrailing(let offset):
            return CGPoint(
                x: min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.maxX + offset),
                y: min(screenSize.height - estimatedHeight / 2 - 16, targetFrame.maxY + offset + estimatedHeight / 2)
            )

        case .center:
            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)

        case .automatic:
            // Automatic positioning logic
            let spaceAbove = targetFrame.minY
            let spaceBelow = screenSize.height - targetFrame.maxY

            if spaceBelow > estimatedHeight + 32 {
                return CGPoint(
                    x: max(tooltipWidth / 2 + 16, min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.midX)),
                    y: targetFrame.maxY + 16 + estimatedHeight / 2
                )
            } else if spaceAbove > estimatedHeight + 32 {
                return CGPoint(
                    x: max(tooltipWidth / 2 + 16, min(screenSize.width - tooltipWidth / 2 - 16, targetFrame.midX)),
                    y: targetFrame.minY - 16 - estimatedHeight / 2
                )
            } else {
                return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
            }
        }
    }
}
