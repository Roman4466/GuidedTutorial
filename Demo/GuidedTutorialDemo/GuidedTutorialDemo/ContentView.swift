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
                        HeaderSection(coordinator: coordinator)

                        GallerySection(
                            coordinator: coordinator,
                            selectedImage: $selectedImage
                        )

                        CounterSection(
                            coordinator: coordinator,
                            counter: $counter
                        )

                        SettingsSection(
                            coordinator: coordinator,
                            isNotificationsEnabled: $isNotificationsEnabled,
                            isDarkMode: $isDarkMode
                        )

                        ProfileSection(
                            coordinator: coordinator,
                            username: $username,
                            email: $email
                        )

                        TutorialControlsSection(
                            coordinator: coordinator,
                            onStartBasicTutorial: { TutorialFlows.basicTutorial(coordinator: coordinator) },
                            onStartAdvancedTutorial: { TutorialFlows.advancedTutorial(coordinator: coordinator) },
                            onStartFeatureShowcase: { TutorialFlows.featureShowcase(coordinator: coordinator) }
                        )
                    }
                    .padding()
                    .onChange(of: coordinator.currentStepIndex) { _ in
                        ScrollHelper.scrollToCurrentTarget(coordinator: coordinator, scrollProxy: scrollProxy)
                    }
                    .onChange(of: coordinator.isPresented) { isPresented in
                        if isPresented {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                ScrollHelper.scrollToCurrentTarget(coordinator: coordinator, scrollProxy: scrollProxy)
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
}

#Preview {
    ContentView(coordinator: TutorialCoordinator())
}
