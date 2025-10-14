//
//  TutorialTargetModifier.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

public struct TutorialTargetModifier: ViewModifier {
    let targetKey: String
    @ObservedObject var coordinator: TutorialCoordinator

    public func body(content: Content) -> some View {
        content
            .captureFrame(key: targetKey)
            .onPreferenceChange(FramePreferenceKey.self) { frames in
                if let frame = frames[targetKey] {
                    coordinator.registerTargetFrame(key: targetKey, frame: frame)
                }
            }
    }
}

public extension View {
    func tutorialTarget(_ key: String, coordinator: TutorialCoordinator) -> some View {
        modifier(TutorialTargetModifier(targetKey: key, coordinator: coordinator))
    }
}
