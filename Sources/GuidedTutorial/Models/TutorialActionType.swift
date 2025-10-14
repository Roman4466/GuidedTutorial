//
//  TutorialActionType.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum TutorialActionType: Equatable {
    case userTap
    case userSwipe(direction: SwipeDirection)
    case userLongPress
    case conditionMet(condition: String)
    case timeout(duration: TimeInterval)
    case custom(identifier: String)

    public static func == (lhs: TutorialActionType, rhs: TutorialActionType) -> Bool {
        switch (lhs, rhs) {
        case (.userTap, .userTap):
            return true
        case (.userSwipe(let dir1), .userSwipe(let dir2)):
            return dir1 == dir2
        case (.userLongPress, .userLongPress):
            return true
        case (.conditionMet(let c1), .conditionMet(let c2)):
            return c1 == c2
        case (.timeout(let d1), .timeout(let d2)):
            return d1 == d2
        case (.custom(let id1), .custom(let id2)):
            return id1 == id2
        default:
            return false
        }
    }
}
