//
//  TutorialControlsSection.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct TutorialControlsSection: View {
    @ObservedObject var coordinator: TutorialCoordinator
    let onStartBasicTutorial: () -> Void
    let onStartAdvancedTutorial: () -> Void
    let onStartFeatureShowcase: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Tutorial Controls")
                .font(.headline)

            HStack(spacing: 15) {
                Button("Basic Tour") {
                    onStartBasicTutorial()
                }
                .buttonStyle(.borderedProminent)
                .tutorialTarget("basicTourButton", coordinator: coordinator)

                Button("Advanced") {
                    onStartAdvancedTutorial()
                }
                .buttonStyle(.bordered)
                .tutorialTarget("advancedTourButton", coordinator: coordinator)
            }

            Button("Features Showcase") {
                onStartFeatureShowcase()
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .tutorialTarget("showcaseButton", coordinator: coordinator)
        }
        .padding()
    }
}
