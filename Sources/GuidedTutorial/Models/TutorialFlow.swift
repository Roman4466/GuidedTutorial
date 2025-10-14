//
//  TutorialFlow.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public struct TutorialFlow: Identifiable {
    public let id: UUID
    public let name: String
    public let steps: [TutorialStep]
    public let canBeSkipped: Bool
    public let skipGesture: SkipGesture?
    public let onComplete: (() -> Void)?
    public let onSkip: (() -> Void)?

    public init(
        id: UUID = UUID(),
        name: String,
        steps: [TutorialStep],
        canBeSkipped: Bool = true,
        skipGesture: SkipGesture? = .swipeDown,
        onComplete: (() -> Void)? = nil,
        onSkip: (() -> Void)? = nil
    ) {
        self.id = id
        self.name = name
        self.steps = steps
        self.canBeSkipped = canBeSkipped
        self.skipGesture = skipGesture
        self.onComplete = onComplete
        self.onSkip = onSkip
    }
}
