//
//  TutorialActionResult.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum TutorialActionResult: Equatable {
    case nextStep
    case skipToStep(index: Int)
    case skipToStepWithId(UUID)
    case completeTutorial
    case restartTutorial
    case customFlow(flowName: String)

    public static func == (lhs: TutorialActionResult, rhs: TutorialActionResult) -> Bool {
        switch (lhs, rhs) {
        case (.nextStep, .nextStep),
             (.completeTutorial, .completeTutorial),
             (.restartTutorial, .restartTutorial):
            return true
        case (.skipToStep(let idx1), .skipToStep(let idx2)):
            return idx1 == idx2
        case (.skipToStepWithId(let id1), .skipToStepWithId(let id2)):
            return id1 == id2
        case (.customFlow(let name1), .customFlow(let name2)):
            return name1 == name2
        default:
            return false
        }
    }
}
