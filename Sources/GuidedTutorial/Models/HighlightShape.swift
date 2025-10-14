//
//  HighlightShape.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum HighlightShape: Equatable {
    case rectangle(cornerRadius: CGFloat = 8)
    case circle
    case roundedRect(cornerRadius: CGFloat)
    case custom(path: () -> any Shape)

    public static func == (lhs: HighlightShape, rhs: HighlightShape) -> Bool {
        switch (lhs, rhs) {
        case (.rectangle(let r1), .rectangle(let r2)):
            return r1 == r2
        case (.circle, .circle):
            return true
        case (.roundedRect(let r1), .roundedRect(let r2)):
            return r1 == r2
        case (.custom, .custom):
            return true
        default:
            return false
        }
    }
}
