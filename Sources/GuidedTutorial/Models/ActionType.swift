//
//  ActionType.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum ActionType: Equatable {
    case tap
    case longPress(duration: TimeInterval = 0.5)
    case swipe(direction: SwipeDirection)
    case doubleTap
    case automatic(delay: TimeInterval)
    case custom(validator: () -> Bool)

    public static func == (lhs: ActionType, rhs: ActionType) -> Bool {
        switch (lhs, rhs) {
        case (.tap, .tap):
            return true
        case (.longPress(let d1), .longPress(let d2)):
            return d1 == d2
        case (.swipe(let dir1), .swipe(let dir2)):
            return dir1 == dir2
        case (.doubleTap, .doubleTap):
            return true
        case (.automatic(let d1), .automatic(let d2)):
            return d1 == d2
        case (.custom, .custom):
            return true
        default:
            return false
        }
    }
}
