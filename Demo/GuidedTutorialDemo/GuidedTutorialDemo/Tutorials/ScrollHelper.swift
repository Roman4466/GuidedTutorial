//
//  ScrollHelper.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct ScrollHelper {

    /// Maps tutorial target keys to scroll section IDs
    private static let scrollTargets: [String: String] = [
        "header": "header",
        "welcomeText": "header",
        "notificationBell": "header",
        "galleryTitle": "imageGallery",
        "imageGallery": "imageGallery",
        "counter": "counter",
        "plusButton": "counter",
        "minusButton": "counter",
        "settingsTitle": "settings",
        "notificationsToggle": "settings",
        "darkModeToggle": "settings",
        "profileTitle": "profile",
        "usernameField": "profile",
        "emailField": "profile",
        "saveButton": "profile",
        "basicTourButton": "profile",
        "advancedTourButton": "profile",
        "showcaseButton": "profile"
    ]

    /// Scrolls to the target for the current tutorial step
    static func scrollToCurrentTarget(coordinator: TutorialCoordinator, scrollProxy: ScrollViewProxy) {
        guard let currentStep = coordinator.currentStep else { return }

        if let scrollId = scrollTargets[currentStep.targetKey] {
            withAnimation(.easeInOut(duration: 0.5)) {
                scrollProxy.scrollTo(scrollId, anchor: .center)
            }
        }
    }
}
