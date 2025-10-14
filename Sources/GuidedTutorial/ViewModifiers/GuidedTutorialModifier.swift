//
//  GuidedTutorialModifier.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

public struct GuidedTutorialModifier: ViewModifier {
    @ObservedObject var coordinator: TutorialCoordinator

    public func body(content: Content) -> some View {
        content
            .overlay(
                TutorialOverlayView(coordinator: coordinator)
            )
    }
}

public extension View {
    func guidedTutorial(coordinator: TutorialCoordinator) -> some View {
        modifier(GuidedTutorialModifier(coordinator: coordinator))
    }
}
