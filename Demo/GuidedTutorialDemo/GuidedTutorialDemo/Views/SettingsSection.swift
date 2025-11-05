//
//  SettingsSection.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct SettingsSection: View {
    @ObservedObject var coordinator: TutorialCoordinator
    @Binding var isNotificationsEnabled: Bool
    @Binding var isDarkMode: Bool

    var body: some View {
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
    }
}
