//
//  ProfileSection.swift.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct ProfileSection: View {
    @ObservedObject var coordinator: TutorialCoordinator
    @Binding var username: String
    @Binding var email: String

    var body: some View {
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
        .background(Color(red: 0.90, green: 0.85, blue: 0.78))
        .cornerRadius(15)
        .id("profile")
    }
}
