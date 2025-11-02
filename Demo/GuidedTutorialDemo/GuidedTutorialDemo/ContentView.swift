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
    @State private var isNotificationsEnabled = true
    @State private var isDarkMode = false
    @State private var selectedTab = 0
    @State private var username = ""
    @State private var email = ""
    @State private var selectedImage = 0

    var body: some View {
        NavigationView {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: 25) {
                        HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome Back!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .tutorialTarget("welcomeText", coordinator: coordinator)

                            Text("Explore all features")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "bell.fill")
                                .font(.title2)
                                .foregroundColor(.orange)
                        }
                        .tutorialTarget("notificationBell", coordinator: coordinator)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    .tutorialTarget("header", coordinator: coordinator)
                    .id("header")

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Gallery")
                            .font(.headline)
                            .tutorialTarget("galleryTitle", coordinator: coordinator)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<5) { index in
                                    Image(systemName: ["photo", "camera", "video", "music.note", "book"][index])
                                        .font(.system(size: 40))
                                        .frame(width: 100, height: 100)
                                        .background(Color.purple.opacity(0.2))
                                        .cornerRadius(12)
                                        .onTapGesture {
                                            selectedImage = index
                                        }
                                }
                            }
                        }
                        .tutorialTarget("imageGallery", coordinator: coordinator)
                    }
                    .id("imageGallery")

                    VStack(spacing: 15) {
                        Text("Interactive Counter")
                            .font(.headline)

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
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(15)
                    .id("counter")

                    // Settings Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Settings")
                            .font(.headline)
                            .tutorialTarget("settingsTitle", coordinator: coordinator)

                        Toggle("Notifications", isOn: $isNotificationsEnabled)
                            .tutorialTarget("notificationsToggle", coordinator: coordinator)

                        Toggle("Dark Mode", isOn: $isDarkMode)
                            .tutorialTarget("darkModeToggle", coordinator: coordinator)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(15)
                    .id("settings")

                    // Form Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Profile")
                            .font(.headline)
                            .tutorialTarget("profileTitle", coordinator: coordinator)

                        TextField("Username", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .tutorialTarget("usernameField", coordinator: coordinator)

                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .tutorialTarget("emailField", coordinator: coordinator)

                        Button("Save Profile") {}
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                            .tutorialTarget("saveButton", coordinator: coordinator)
                    }
                    .padding()
                    .background(Color.pink.opacity(0.1))
                    .cornerRadius(15)
                    .id("profile")

                    // Tutorial Controls
                    VStack(spacing: 12) {
                        Text("Tutorial Controls")
                            .font(.headline)

                        HStack(spacing: 15) {
                            Button("Basic Tour") {
                                startBasicTutorial()
                            }
                            .buttonStyle(.borderedProminent)
                            .tutorialTarget("basicTourButton", coordinator: coordinator)

                            Button("Advanced") {
                                startAdvancedTutorial()
                            }
                            .buttonStyle(.bordered)
                            .tutorialTarget("advancedTourButton", coordinator: coordinator)
                        }

                        Button("Features Showcase") {
                            startFeatureShowcase()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.purple)
                        .tutorialTarget("showcaseButton", coordinator: coordinator)
                    }
                    .padding()
                }
                .padding()
                .onChange(of: coordinator.currentStepIndex) { _ in
                    scrollToCurrentTarget(scrollProxy: scrollProxy)
                }
                .onChange(of: coordinator.isPresented) { isPresented in
                    if isPresented {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            scrollToCurrentTarget(scrollProxy: scrollProxy)
                        }
                    }
                }
            }
            .navigationTitle("Tutorial Demo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "gear")
                    }
                    .tutorialTarget("settingsIcon", coordinator: coordinator)
                }
            }
        }
        }
    }

    private func scrollToCurrentTarget(scrollProxy: ScrollViewProxy) {
        guard let currentStep = coordinator.currentStep else { return }

        let scrollTargets: [String: String] = [
            "header": "header",
            "welcomeText": "header",
            "notificationBell": "header",
            "galleryTitle": "imageGallery",
            "imageGallery": "imageGallery",
            "counter": "counter",
            "plusButton": "counter",
            "minusButton": "counter",
            "settingsTitle": "settings",
            "notificationsToggle": "settings",
            "darkModeToggle": "settings",
            "profileTitle": "profile",
            "usernameField": "profile",
            "emailField": "profile",
            "saveButton": "profile",
            "basicTourButton": "profile",
            "advancedTourButton": "profile",
            "showcaseButton": "profile"
        ]

        if let scrollId = scrollTargets[currentStep.targetKey] {
            withAnimation(.easeInOut(duration: 0.5)) {
                scrollProxy.scrollTo(scrollId, anchor: .center)
            }
        }
    }

    // MARK: - Basic Tutorial
    private func startBasicTutorial() {
        let steps = [
            TutorialStep(
                targetKey: "header",
                title: "Welcome! 👋",
                description: "This is the main header of the app. It shows your welcome message and quick access to notifications.",
                highlightShape: .roundedRect(cornerRadius: 15),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "notificationBell",
                title: "Notifications",
                description: "Tap here to view your notifications and stay updated.",
                highlightShape: .circle,
                tooltipPosition: .bottomLeading(offset: 15)
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Counter Display",
                description: "This shows the current counter value. Use the buttons on either side to adjust it.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .top(offset: 20)
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Increase",
                description: "Tap to increment the counter.",
                highlightShape: .circle,
                tooltipPosition: .leading(offset: 20)
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Decrease",
                description: "Tap to decrement the counter.",
                highlightShape: .circle,
                tooltipPosition: .trailing(offset: 20)
            )
        ]

        let flow = TutorialFlow(
            name: "Basic Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print("✅ Basic tutorial completed!")
            },
            onSkip: {
                print("⏭️ Basic tutorial skipped!")
            }
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Advanced Tutorial
    private func startAdvancedTutorial() {
        let steps = [
            TutorialStep(
                targetKey: "imageGallery",
                title: "Image Gallery",
                description: "Swipe through the gallery to view different media types. This demonstrates horizontal scrolling content.",
                highlightShape: .roundedRect(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.point.left.fill")
                                    .foregroundColor(.blue)
                                Text("Swipe to explore")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    )
                }
            ),
            TutorialStep(
                targetKey: "settingsTitle",
                title: "Settings Section",
                description: "Configure your app preferences here. Let's explore the available options.",
                highlightShape: .rectangle(cornerRadius: 8),
                actionType: .automatic(delay: 2.0),
                tooltipPosition: .bottom(offset: 15)
            ),
            TutorialStep(
                targetKey: "notificationsToggle",
                title: "Notifications Toggle",
                description: "Enable or disable push notifications. Changes take effect immediately.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 15)
            ),
            TutorialStep(
                targetKey: "darkModeToggle",
                title: "Dark Mode",
                description: "Switch between light and dark themes for comfortable viewing.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .topTrailing(offset: 15)
            ),
            TutorialStep(
                targetKey: "usernameField",
                title: "Username Field",
                description: "Enter your preferred username. This will be displayed throughout the app.",
                highlightShape: .roundedRect(cornerRadius: 6),
                tooltipPosition: .bottom(offset: 15)
            ),
            TutorialStep(
                targetKey: "saveButton",
                title: "Save Changes",
                description: "Don't forget to save your profile changes when you're done editing.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 15),
                showArrow: true
            )
        ]

        let flow = TutorialFlow(
            name: "Advanced Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeUp,
            onComplete: {
                print("✅ Advanced tutorial completed!")
            },
            onSkip: {
                print("⏭️ Advanced tutorial skipped!")
            }
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Feature Showcase
    private func startFeatureShowcase() {
        let steps = [
            TutorialStep(
                targetKey: "welcomeText",
                title: "Bottom-Right Position",
                description: "Tooltips can be positioned at the bottom-right corner of any element.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottomTrailing(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "galleryTitle",
                title: "Top-Left Position",
                description: "This tooltip is positioned at the top-left. Great for corner placements!",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .topLeading(offset: 15),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "settingsIcon",
                title: "Automatic Positioning",
                description: "The tooltip automatically finds the best position based on available space. It will never overlap the highlighted element!",
                highlightShape: .circle,
                tooltipPosition: .automatic,
                showArrow: true
            ),
            TutorialStep(
                targetKey: "profileTitle",
                title: "Custom Content",
                description: "Tooltips can include custom views with images, buttons, and more.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottom(offset: 15),
                showArrow: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 10) {
                            HStack(spacing: 5) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            Text("Premium Feature")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                        }
                    )
                }
            ),
            TutorialStep(
                targetKey: "emailField",
                title: "No Arrow Style",
                description: "This step demonstrates a tooltip without an arrow. Sometimes less is more!",
                highlightShape: .roundedRect(cornerRadius: 6),
                tooltipPosition: .top(offset: 15),
                showArrow: false
            ),
            TutorialStep(
                targetKey: "basicTourButton",
                title: "Circle Highlight",
                description: "Different highlight shapes are available: circle, rectangle, and rounded rectangle.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "showcaseButton",
                title: "Tutorial Complete! 🎉",
                description: "You've seen all the major features: different positions, shapes, arrows, and custom content. Try the other tutorials to see more!",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            Text("✨ Features Covered ✨")
                                .font(.caption)
                                .fontWeight(.bold)
                            HStack(spacing: 15) {
                                Label("Positions", systemImage: "arrow.up.left.and.arrow.down.right")
                                Label("Shapes", systemImage: "circle.square")
                                Label("Arrows", systemImage: "arrow.right")
                            }
                            .font(.caption2)
                        }
                        .foregroundColor(.purple)
                    )
                }
            )
        ]

        let flow = TutorialFlow(
            name: "Feature Showcase",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .doubleTap,
            onComplete: {
                print("✅ Feature showcase completed!")
            },
            onSkip: {
                print("⏭️ Feature showcase skipped!")
            }
        )

        coordinator.startFlow(flow)
    }
}

#Preview {
    ContentView(coordinator: TutorialCoordinator())
}
