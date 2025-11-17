//
//  ActionGestureOverlay.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 17.11.2025.
//

import SwiftUI

/// Overlay that handles ActionType gestures (swipe, doubleTap, longPress) for advancing tutorial steps
struct ActionGestureOverlay: View {
    let actionType: ActionType
    let onAction: () -> Void

    @State private var tapCount = 0

    var body: some View {
        GeometryReader { geometry in
            Group {
                switch actionType {
                case .swipe(let direction):
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 50)
                                .onEnded { value in
                                    handleSwipe(value: value, direction: direction)
                                }
                        )

                case .doubleTap:
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            TapGesture(count: 1)
                                .onEnded { _ in
                                    handleDoubleTap()
                                }
                        )

                case .longPress(let duration):
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            LongPressGesture(minimumDuration: duration)
                                .onEnded { _ in
                                    onAction()
                                }
                        )

                default:
                    Color.clear
                }
            }
        }
    }

    private func handleSwipe(value: DragGesture.Value, direction: SwipeDirection) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height

        switch direction {
        case .right:
            if horizontalAmount > 80 && abs(verticalAmount) < 50 {
                onAction()
            }
        case .left:
            if horizontalAmount < -80 && abs(verticalAmount) < 50 {
                onAction()
            }
        case .up:
            if verticalAmount < -80 && abs(horizontalAmount) < 50 {
                onAction()
            }
        case .down:
            if verticalAmount > 80 && abs(horizontalAmount) < 50 {
                onAction()
            }
        }
    }

    private func handleDoubleTap() {
        let currentCount = tapCount + 1
        tapCount = currentCount

        // If this is the second tap within the window, trigger action
        if currentCount == 2 {
            tapCount = 0
            onAction()
        } else {
            // Wait for potential second tap
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if tapCount == 1 {
                    tapCount = 0
                }
            }
        }
    }
}
