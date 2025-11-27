import SwiftUI
import GuidedTutorial

struct ContentView: View {
    @StateObject private var coordinator = TutorialCoordinator()
    @State private var consoleOutput: [String] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("WCAG Accessibility Warning Demo")
                .font(.title)
                .padding()

            Button("Show Bad Contrast Tutorial") {
                startBadContrastTutorial()
            }
            .buttonStyle(.borderedProminent)
            .tutorialTarget("badButton", coordinator: coordinator)

            Divider()
                .padding(.vertical)

            VStack(alignment: .leading, spacing: 10) {
                Text("Console Output:")
                    .font(.headline)

                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(consoleOutput.indices, id: \.self) { index in
                            Text(consoleOutput[index])
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.red)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 200)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(8)
            }
            .padding(.horizontal)

            Text("Check Xcode console for detailed accessibility warnings")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tutorialOverlay(coordinator: coordinator)
    }

    private func startBadContrastTutorial() {
        consoleOutput.removeAll()

        // Create a tooltip style with BAD contrast (light gray on white)
        let badStyle = TooltipStyle(
            backgroundColor: .white,
            titleColor: Color(red: 0.8, green: 0.8, blue: 0.8), // Light gray - BAD!
            descriptionColor: Color(red: 0.7, green: 0.7, blue: 0.7), // Light gray - BAD!
            cornerRadius: 12,
            shadowRadius: 8,
            padding: 20,
            titleFont: .headline,
            descriptionFont: .subheadline
        )

        let step = TutorialStep(
            targetKey: "badButton",
            title: "Bad Contrast Example",
            description: "This tooltip has poor color contrast and will trigger WCAG warnings in the console.",
            highlightShape: .roundedRect(cornerRadius: 12),
            tooltipPosition: .top(offset: 20),
            tooltipStyle: badStyle
        )

        // Enable accessibility validation (enabled by default in DEBUG)
        let flow = TutorialFlow(
            name: "Bad Contrast Tutorial",
            steps: [step],
            canBeSkipped: true,
            validateAccessibility: true, // This will trigger warnings in console
            onComplete: {
                print("Tutorial completed!")
            }
        )

        // Simulate console output for UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            consoleOutput.append("⚠️ Accessibility Warning in 'Bad Contrast Tutorial' step 1 (Bad Contrast Example):")
            consoleOutput.append("  - Title color contrast ratio 1.2:1 is below WCAG AA standard (4.5:1 required)")
            consoleOutput.append("  - Description color contrast ratio 1.5:1 is below WCAG AA standard (4.5:1 required)")
        }

        coordinator.startFlow(flow)
    }
}
