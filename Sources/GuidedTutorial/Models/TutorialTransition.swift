//
//  TutorialTransition.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public struct TutorialTransition {
    public let animation: TutorialAnimation
    public let duration: TimeInterval

    public init(
        animation: TutorialAnimation = .fade,
        duration: TimeInterval = 0.3
    ) {
        self.animation = animation
        self.duration = duration
    }
}

public enum TutorialAnimation: Equatable {
    case fade
    case slide
    case scale
    case custom
}
