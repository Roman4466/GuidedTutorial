//
//  TutorialOverlayView.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct TutorialOverlayView: View {
    @ObservedObject var coordinator: TutorialCoordinator

    var body: some View {
        GeometryReader { geometry in
            if coordinator.isPresented,
               let currentStep = coordinator.currentStep,
               let targetFrame = coordinator.targetFrames[currentStep.targetKey] {

                ZStack {
                    if let skipGesture = coordinator.currentFlow?.skipGesture {
                        GestureOverlay(skipGesture: skipGesture) {
                            coordinator.skipTutorial()
                        }
                    }

                    SpotlightOverlay(
                        targetFrame: targetFrame,
                        highlightShape: currentStep.highlightShape,
                        blurStyle: currentStep.blurStyle ?? coordinator.currentFlow?.defaultBlurStyle ?? .default
                    )
                    .allowsHitTesting(false)

                    if currentStep.showArrow {
                        ArrowView(
                            from: calculateTooltipPosition(
                                step: currentStep,
                                targetFrame: targetFrame,
                                screenSize: geometry.size
                            ),
                            to: calculateArrowTargetPoint(
                                tooltipPosition: currentStep.tooltipPosition,
                                targetFrame: targetFrame
                            ),
                            color: .blue
                        )
                        .allowsHitTesting(false)
                    }

                    TooltipView(
                        step: currentStep,
                        targetFrame: targetFrame,
                        screenSize: geometry.size,
                        onNext: {
                            coordinator.nextStep()
                        },
                        onSkip: coordinator.currentFlow?.canBeSkipped == true ? {
                            coordinator.skipTutorial()
                        } : nil,
                        tooltipStyle: currentStep.tooltipStyle ?? coordinator.currentFlow?.defaultTooltipStyle ?? .default
                    )
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .transition(.opacity)
                .animation(.easeInOut, value: coordinator.currentStepIndex)
            }
        }
        .ignoresSafeArea()
    }

    private func calculateTooltipPosition(step: TutorialStep, targetFrame: CGRect, screenSize: CGSize) -> CGPoint {
        let tooltipWidth: CGFloat = min(screenSize.width - 32, 320)
        let estimatedHeight: CGFloat = 150
        let padding: CGFloat = 16

        switch step.tooltipPosition {
        case .top(let offset):
            let yPos = targetFrame.minY - offset - estimatedHeight / 2
            let xPos = max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, targetFrame.midX))
            return CGPoint(x: xPos, y: max(estimatedHeight / 2 + padding, yPos))

        case .bottom(let offset):
            let yPos = targetFrame.maxY + offset + estimatedHeight / 2
            let xPos = max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, targetFrame.midX))
            return CGPoint(x: xPos, y: min(screenSize.height - estimatedHeight / 2 - padding, yPos))

        case .leading(let offset):
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            let yPos = max(estimatedHeight / 2 + padding, min(screenSize.height - estimatedHeight / 2 - padding, targetFrame.midY))
            return CGPoint(x: max(tooltipWidth / 2 + padding, xPos), y: yPos)

        case .trailing(let offset):
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            let yPos = max(estimatedHeight / 2 + padding, min(screenSize.height - estimatedHeight / 2 - padding, targetFrame.midY))
            return CGPoint(x: min(screenSize.width - tooltipWidth / 2 - padding, xPos), y: yPos)

        case .topLeading(let offset):
            let yPos = targetFrame.minY - offset - estimatedHeight / 2
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: max(estimatedHeight / 2 + padding, yPos)
            )

        case .topTrailing(let offset):
            let yPos = targetFrame.minY - offset - estimatedHeight / 2
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: max(estimatedHeight / 2 + padding, yPos)
            )

        case .bottomLeading(let offset):
            let yPos = targetFrame.maxY + offset + estimatedHeight / 2
            let xPos = targetFrame.minX - offset - tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: min(screenSize.height - estimatedHeight / 2 - padding, yPos)
            )

        case .bottomTrailing(let offset):
            let yPos = targetFrame.maxY + offset + estimatedHeight / 2
            let xPos = targetFrame.maxX + offset + tooltipWidth / 2
            return CGPoint(
                x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, xPos)),
                y: min(screenSize.height - estimatedHeight / 2 - padding, yPos)
            )

        case .center:
            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)

        case .automatic:
            let spaceAbove = targetFrame.minY
            let spaceBelow = screenSize.height - targetFrame.maxY
            let spaceLeft = targetFrame.minX
            let spaceRight = screenSize.width - targetFrame.maxX

            let positions = [
                (space: spaceBelow, position: CGPoint(
                    x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, targetFrame.midX)),
                    y: targetFrame.maxY + padding + estimatedHeight / 2
                )),
                (space: spaceAbove, position: CGPoint(
                    x: max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, targetFrame.midX)),
                    y: targetFrame.minY - padding - estimatedHeight / 2
                )),
                (space: spaceRight, position: CGPoint(
                    x: targetFrame.maxX + padding + tooltipWidth / 2,
                    y: max(estimatedHeight / 2 + padding, min(screenSize.height - estimatedHeight / 2 - padding, targetFrame.midY))
                )),
                (space: spaceLeft, position: CGPoint(
                    x: targetFrame.minX - padding - tooltipWidth / 2,
                    y: max(estimatedHeight / 2 + padding, min(screenSize.height - estimatedHeight / 2 - padding, targetFrame.midY))
                ))
            ]

            if let bestPosition = positions.max(by: { $0.space < $1.space })?.position {
                let clampedX = max(tooltipWidth / 2 + padding, min(screenSize.width - tooltipWidth / 2 - padding, bestPosition.x))
                let clampedY = max(estimatedHeight / 2 + padding, min(screenSize.height - estimatedHeight / 2 - padding, bestPosition.y))
                return CGPoint(x: clampedX, y: clampedY)
            }

            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        }
    }

    private func calculateArrowTargetPoint(tooltipPosition: TooltipPosition, targetFrame: CGRect) -> CGPoint {
        switch tooltipPosition {
        case .top:
            return CGPoint(x: targetFrame.midX, y: targetFrame.minY)
        case .bottom:
            return CGPoint(x: targetFrame.midX, y: targetFrame.maxY)
        case .leading:
            return CGPoint(x: targetFrame.minX, y: targetFrame.midY)
        case .trailing:
            return CGPoint(x: targetFrame.maxX, y: targetFrame.midY)
        case .topLeading:
            return CGPoint(x: targetFrame.minX, y: targetFrame.minY)
        case .topTrailing:
            return CGPoint(x: targetFrame.maxX, y: targetFrame.minY)
        case .bottomLeading:
            return CGPoint(x: targetFrame.minX, y: targetFrame.maxY)
        case .bottomTrailing:
            return CGPoint(x: targetFrame.maxX, y: targetFrame.maxY)
        case .center:
            return CGPoint(x: targetFrame.midX, y: targetFrame.midY)
        case .automatic:
            // For automatic, determine based on available space
            return CGPoint(x: targetFrame.midX, y: targetFrame.midY)
        }
    }
}
