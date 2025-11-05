//
//  GestureOverlay.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct GestureOverlay: View {
    let skipGesture: SkipGesture
    let onSkip: () -> Void

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .contentShape(Rectangle())
                .simultaneousGesture(createGesture())
        }
    }

    private func createGesture() -> some Gesture {
        DragGesture(minimumDistance: 100)
            .onEnded { value in
                handleGestureEnd(value: value)
            }
    }

    private func handleGestureEnd(value: DragGesture.Value) {
        let velocity = CGSize(
            width: value.predictedEndLocation.x - value.location.x,
            height: value.predictedEndLocation.y - value.location.y
        )

        switch skipGesture {
        case .swipeDown:
            // Require strong downward swipe with high velocity
            if value.translation.height > 150
                && abs(value.translation.width) < 80
                && velocity.height > 100 {
                onSkip()
            }

        case .swipeUp:
            // Require strong upward swipe with high velocity
            if value.translation.height < -150
                && abs(value.translation.width) < 80
                && velocity.height < -100 {
                onSkip()
            }

        default:
            break
        }
    }
}
