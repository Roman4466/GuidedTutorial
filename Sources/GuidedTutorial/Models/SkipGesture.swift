//
//  SkipGesture.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import Foundation

public enum SkipGesture: Equatable {
    case swipeDown
    case swipeUp
    case doubleTap
    case longPress
    case button

    public static func == (lhs: SkipGesture, rhs: SkipGesture) -> Bool {
        switch (lhs, rhs) {
        case (.swipeDown, .swipeDown),
             (.swipeUp, .swipeUp),
             (.doubleTap, .doubleTap),
             (.longPress, .longPress),
             (.button, .button):
            return true
        default:
            return false
        }
    }
}
