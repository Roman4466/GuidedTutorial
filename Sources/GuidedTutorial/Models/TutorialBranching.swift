//
//  TutorialBranching.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public struct TutorialBranching {
    public let condition: () -> Bool
    public let trueStep: UUID
    public let falseStep: UUID

    public init(
        condition: @escaping () -> Bool,
        trueStep: UUID,
        falseStep: UUID
    ) {
        self.condition = condition
        self.trueStep = trueStep
        self.falseStep = falseStep
    }
}
