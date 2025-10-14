//
//  TutorialFlowState.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum TutorialFlowState: Equatable {
    case notStarted
    case inProgress(currentStepIndex: Int)
    case completed
    case skipped

    public static func == (lhs: TutorialFlowState, rhs: TutorialFlowState) -> Bool {
        switch (lhs, rhs) {
        case (.notStarted, .notStarted),
             (.completed, .completed),
             (.skipped, .skipped):
            return true
        case (.inProgress(let idx1), .inProgress(let idx2)):
            return idx1 == idx2
        default:
            return false
        }
    }
}
