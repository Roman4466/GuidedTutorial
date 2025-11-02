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
                        dimColor: .black,
                        dimOpacity: 0.7
                    )
                    .allowsHitTesting(false)

                    if currentStep.showArrow {
                        ArrowView(
                            from: calculateTooltipPosition(
                                step: currentStep,
                                targetFrame: targetFrame,
                                screenSize: geometry.size
                            ),
                            to: CGPoint(x: targetFrame.midX, y: targetFrame.midY),
                            color: .blue
                        )
                        .allowsHitTesting(false)
                    }

                    // Tooltip (on top to receive button taps)
                    TooltipView(
                        step: currentStep,
                        targetFrame: targetFrame,
                        screenSize: geometry.size,
                        onNext: {
                            coordinator.nextStep()
                        },
                        onSkip: coordinator.currentFlow?.canBeSkipped == true ? {
                            coordinator.skipTutorial()
                        } : nil
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
        switch step.tooltipPosition {
        case .top:
            return CGPoint(x: targetFrame.midX, y: targetFrame.minY - 100)
        case .bottom:
            return CGPoint(x: targetFrame.midX, y: targetFrame.maxY + 100)
        case .leading:
            return CGPoint(x: targetFrame.minX - 100, y: targetFrame.midY)
        case .trailing:
            return CGPoint(x: targetFrame.maxX + 100, y: targetFrame.midY)
        case .automatic:
            let spaceBelow = screenSize.height - targetFrame.maxY
            if spaceBelow > 200 {
                return CGPoint(x: targetFrame.midX, y: targetFrame.maxY + 100)
            } else {
                return CGPoint(x: targetFrame.midX, y: targetFrame.minY - 100)
            }
        default:
            return CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        }
    }
}
