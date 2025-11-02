//
//  ContentView.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI
import GuidedTutorial

struct ContentView: View {
    @ObservedObject var coordinator: TutorialCoordinator
    @State private var counter = 0

    var body: some View {
        ZStack {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: 30) {
                Text("Guided Tutorial Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .tutorialTarget("title", coordinator: coordinator)

                Image(systemName: "star.fill")
                    .imageScale(.large)
                    .font(.system(size: 60))
                    .foregroundStyle(.yellow)
                    .tutorialTarget("icon", coordinator: coordinator)

                HStack(spacing: 20) {
                    Button {
                        counter -= 1
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.title)
                    }
                    .tutorialTarget("minusButton", coordinator: coordinator)

                    Text("\(counter)")
                        .font(.system(size: 48, weight: .bold))
                        .frame(width: 100)
                        .tutorialTarget("counter", coordinator: coordinator)

                    Button {
                        counter += 1
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .tutorialTarget("plusButton", coordinator: coordinator)
                }

                Button("Start Tutorial") {
                    startTutorial()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
        }
    }

    private func startTutorial() {
        let steps = [
            TutorialStep(
                targetKey: "title",
                title: "Welcome!",
                description: "This is the title of the app. Tutorial will guide you through the features.",
                highlightShape: .rectangle(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20)
            ),
            TutorialStep(
                targetKey: "icon",
                title: "Star Icon",
                description: "This is a decorative star icon. Pretty cool, right?",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 30)
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Counter Display",
                description: "This shows the current counter value. You can change it with the buttons.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 20)
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Increment Button",
                description: "Tap this button to increase the counter value.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20)
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Decrement Button",
                description: "Tap this button to decrease the counter value.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20)
            )
        ]

        let flow = TutorialFlow(
            name: "Main Tutorial",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print("Tutorial completed!")
            },
            onSkip: {
                print("Tutorial skipped!")
            }
        )

        coordinator.startFlow(flow)
    }
}

#Preview {
    ContentView(coordinator: TutorialCoordinator())
}
