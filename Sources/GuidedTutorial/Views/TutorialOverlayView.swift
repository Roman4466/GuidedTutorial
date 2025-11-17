//
//  TutorialOverlayView.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct TutorialOverlayView: View {
    @ObservedObject var coordinator: TutorialCoordinator
    @Environment(\.accessibilityReduceMotion) var reduceMotion

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
                            from: calculateEstimatedTooltipPosition(
                                step: currentStep,
                                targetFrame: targetFrame,
                                screenSize: geometry.size,
                                tooltipStyle: currentStep.tooltipStyle ?? coordinator.currentFlow?.defaultTooltipStyle ?? .default
                            ),
                            to: calculateArrowTargetPoint(
                                tooltipPosition: currentStep.tooltipPosition,
                                targetFrame: targetFrame
                            ),
                            arrowStyle: currentStep.arrowStyle ?? coordinator.currentFlow?.defaultArrowStyle ?? .default
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
                .animation(reduceMotion ? .none : .easeInOut, value: coordinator.currentStepIndex)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Tutorial overlay")
            }
        }
        .ignoresSafeArea()
    }

    /// Calculates estimated tooltip position for arrow placement
    /// Uses estimated size since the tooltip hasn't been rendered yet
    private func calculateEstimatedTooltipPosition(
        step: TutorialStep,
        targetFrame: CGRect,
        screenSize: CGSize,
        tooltipStyle: TooltipStyle
    ) -> CGPoint {
        // Estimate tooltip size (will be replaced with actual size once tooltip renders)
        let estimatedWidth = tooltipStyle.maxWidth ?? min(screenSize.width - (tooltipStyle.padding * 2), 320)
        let estimatedHeight: CGFloat = 200  // Conservative estimate matching TooltipView default

        return TooltipPositionCalculator.calculatePosition(
            tooltipPosition: step.tooltipPosition,
            targetFrame: targetFrame,
            screenSize: screenSize,
            tooltipSize: CGSize(width: estimatedWidth, height: estimatedHeight),
            tooltipStyle: tooltipStyle
        )
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
