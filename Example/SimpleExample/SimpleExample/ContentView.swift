//
//  ContentView.swift
//  SimpleExample
//
//  Created by Roman Malynovsky on 28.11.2025.
//

import SwiftUI
import GuidedTutorial

struct ContentView: View {
    @StateObject private var coordinator = TutorialCoordinator()

    var body: some View {
        VStack(spacing: 40) {
            Button("Start Tutorial") {
                startSimpleTutorial()
            }
            .tutorialTarget("startButton", coordinator: coordinator)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .guidedTutorial(coordinator: coordinator)
    }

    private func startSimpleTutorial() {
        let step = TutorialStep(
            targetKey: "startButton",
            title: "Welcome!",
            description: "This is your first tutorial. Tap this button to complete the tutorial.",
        )
        let flow = TutorialFlow(
            name: "Simple Tutorial",
            steps: [step],
            canBeSkipped: false,
        )
        coordinator.startFlow(flow)
    }
}

#Preview {
    ContentView()
}
