//
//  HeaderSection.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct HeaderSection: View {
    @ObservedObject var coordinator: TutorialCoordinator

    var body: some View {
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
                    .foregroundColor(Color(red: 0.7, green: 0.5, blue: 0.3))
            }
            .tutorialTarget("notificationBell", coordinator: coordinator)
        }
        .padding()
        .background(Color(red: 0.95, green: 0.92, blue: 0.88))
        .cornerRadius(15)
        .tutorialTarget("header", coordinator: coordinator)
        .id("header")
    }
}
