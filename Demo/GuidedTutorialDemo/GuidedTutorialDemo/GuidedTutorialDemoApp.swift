//
//  GuidedTutorialDemoApp.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI
import GuidedTutorial

@main
struct GuidedTutorialDemoApp: App {
    @StateObject private var coordinator = TutorialCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: coordinator)
                .guidedTutorial(coordinator: coordinator)
        }
    }
}
