import SwiftUI
import GuidedTutorial

struct ContentView: View {
    @StateObject private var coordinator = TutorialCoordinator()

    var body: some View {
        VStack(spacing: 40) {
            Text("Simple Tutorial Example")
                .font(.largeTitle)
                .padding()

            Button("Start Tutorial") {
                startSimpleTutorial()
            }
            .buttonStyle(.borderedProminent)
            .tutorialTarget("startButton", coordinator: coordinator)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tutorialOverlay(coordinator: coordinator)
        .onAppear {
            // Auto-start tutorial when app opens
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                startSimpleTutorial()
            }
        }
    }

    private func startSimpleTutorial() {
        let step = TutorialStep(
            targetKey: "startButton",
            title: "Welcome!",
            description: "This is your first tutorial. Tap this button to complete the tutorial.",
            highlightShape: .roundedRect(cornerRadius: 12),
            tooltipPosition: .bottom(offset: 20),
            showArrow: true
        )

        let flow = TutorialFlow(
            name: "Simple Tutorial",
            steps: [step],
            canBeSkipped: false,
            onComplete: {
                print("Tutorial completed!")
            }
        )

        coordinator.startFlow(flow)
    }
}
