//
//  TutorialAction.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public struct TutorialAction: Identifiable {
    public let id: UUID
    public let stepId: UUID
    public let actionType: TutorialActionType
    public let nextStep: TutorialActionResult

    public init(
        id: UUID = UUID(),
        stepId: UUID,
        actionType: TutorialActionType,
        nextStep: TutorialActionResult
    ) {
        self.id = id
        self.stepId = stepId
        self.actionType = actionType
        self.nextStep = nextStep
    }
}
