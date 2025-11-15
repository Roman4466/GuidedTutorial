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
    let onStartGalleryTutorial: () -> Void
    let onStartCustomizationDemo: () -> Void
    let onStartAccessibilityDemo: () -> Void

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

            HStack(spacing: 15) {
                Button("Features Showcase") {
                    onStartFeatureShowcase()
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                .tutorialTarget("showcaseButton", coordinator: coordinator)

                Button("Gallery Tour") {
                    onStartGalleryTutorial()
                }
                .buttonStyle(.bordered)
                .tutorialTarget("galleryTourButton", coordinator: coordinator)
            }

            HStack(spacing: 15) {
                Button("Customization Demo") {
                    onStartCustomizationDemo()
                }
                .buttonStyle(.bordered)
                .tutorialTarget("customizationButton", coordinator: coordinator)

                Button("Accessibility Demo") {
                    onStartAccessibilityDemo()
                }
                .buttonStyle(.bordered)
                .tutorialTarget("accessibilityButton", coordinator: coordinator)
            }
        }
        .padding()
    }
}
