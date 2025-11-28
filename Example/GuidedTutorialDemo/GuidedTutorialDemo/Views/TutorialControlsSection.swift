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
    let onStartGalleryTutorial: () -> Void
    let onStartCustomizationDemo: () -> Void
    let onStartAccessibilityDemo: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Tutorial Controls")
                .font(.headline)

            HStack(spacing: 15) {
                Button("Main Tour") {
                    onStartBasicTutorial()
                }
                .buttonStyle(.borderedProminent)
                .tutorialTarget("basicTourButton", coordinator: coordinator)
            }

            HStack(spacing: 15) {
                Button("Gallery Tour") {
                    onStartGalleryTutorial()
                }
                .buttonStyle(.borderedProminent)
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
