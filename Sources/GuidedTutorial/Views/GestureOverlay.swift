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
                .gesture(createGesture())
        }
    }

    private func createGesture() -> _EndedGesture<DragGesture> {
        DragGesture(minimumDistance: 50)
            .onEnded { value in
                handleGestureEnd(value: value)
            }
    }

    private func handleGestureEnd(value: DragGesture.Value) {
        switch skipGesture {
        case .swipeDown:
            if value.translation.height > 100 && abs(value.translation.width) < 50 {
                onSkip()
            }

        case .swipeUp:
            if value.translation.height < -100 && abs(value.translation.width) < 50 {
                onSkip()
            }

        default:
            break
        }
    }
}
