//
//  TutorialEvent.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum TutorialEvent: Equatable {
    case stepStarted(stepId: UUID)
    case stepCompleted(stepId: UUID)
    case stepSkipped(stepId: UUID)
    case tutorialStarted
    case tutorialCompleted
    case tutorialSkipped
    case actionPerformed(actionType: TutorialActionType)

    public static func == (lhs: TutorialEvent, rhs: TutorialEvent) -> Bool {
        switch (lhs, rhs) {
        case (.stepStarted(let id1), .stepStarted(let id2)),
             (.stepCompleted(let id1), .stepCompleted(let id2)),
             (.stepSkipped(let id1), .stepSkipped(let id2)):
            return id1 == id2
        case (.tutorialStarted, .tutorialStarted),
             (.tutorialCompleted, .tutorialCompleted),
             (.tutorialSkipped, .tutorialSkipped):
            return true
        case (.actionPerformed(let action1), .actionPerformed(let action2)):
            return action1 == action2
        default:
            return false
        }
    }
}
