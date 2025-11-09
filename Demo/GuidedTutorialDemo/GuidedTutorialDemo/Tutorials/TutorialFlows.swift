//
//  TutorialFlows.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import Foundation
import GuidedTutorial
import SwiftUI

struct TutorialFlows {

    // MARK: - Basic Tutorial
    static func basicTutorial(coordinator: TutorialCoordinator) {
        let steps = [
            TutorialStep(
                targetKey: "header",
                title: "Welcome! 👋",
                description: "This is the main header of the app. It shows your welcome message and quick access to notifications.",
                highlightShape: .roundedRect(cornerRadius: 15),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "notificationBell",
                title: "Notifications",
                description: "Tap here to view your notifications and stay updated.",
                highlightShape: .circle,
                tooltipPosition: .bottomLeading(offset: 15)
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Counter Display",
                description: "This shows the current counter value. Use the buttons on either side to adjust it.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .top(offset: 20)
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Increase",
                description: "Tap to increment the counter.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Decrease",
                description: "Tap to decrement the counter.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true
            )
        ]

        let flow = TutorialFlow(
            name: "Basic Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print("✅ Basic tutorial completed!")
            },
            onSkip: {
                print("⏭️ Basic tutorial skipped!")
            }
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Advanced Tutorial
    static func advancedTutorial(coordinator: TutorialCoordinator) {
        let steps = [
            TutorialStep(
                targetKey: "imageGallery",
                title: "Image Gallery",
                description: "Swipe through the gallery to view different media types. This demonstrates horizontal scrolling content.",
                highlightShape: .roundedRect(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.point.left.fill")
                                    .foregroundColor(.blue)
                                Text("Swipe to explore")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    )
                }
            ),
            TutorialStep(
                targetKey: "settingsTitle",
                title: "Settings Section",
                description: "Configure your app preferences here. Let's explore the available options.",
                highlightShape: .rectangle(cornerRadius: 8),
                actionType: .automatic(delay: 2.0),
                tooltipPosition: .bottom(offset: 15)
            ),
            TutorialStep(
                targetKey: "notificationsToggle",
                title: "Notifications Toggle",
                description: "Enable or disable push notifications. Changes take effect immediately.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 15)
            ),
            TutorialStep(
                targetKey: "darkModeToggle",
                title: "Dark Mode",
                description: "Switch between light and dark themes for comfortable viewing.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .topTrailing(offset: 15)
            ),
            TutorialStep(
                targetKey: "usernameField",
                title: "Username Field",
                description: "Enter your preferred username. This will be displayed throughout the app.",
                highlightShape: .roundedRect(cornerRadius: 6),
                tooltipPosition: .bottom(offset: 15)
            ),
            TutorialStep(
                targetKey: "saveButton",
                title: "Save Changes",
                description: "Don't forget to save your profile changes when you're done editing.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 15),
                showArrow: true
            )
        ]

        let flow = TutorialFlow(
            name: "Advanced Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeUp,
            onComplete: {
                print("✅ Advanced tutorial completed!")
            },
            onSkip: {
                print("⏭️ Advanced tutorial skipped!")
            }
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Feature Showcase
    static func featureShowcase(coordinator: TutorialCoordinator) {
        let steps = [
            TutorialStep(
                targetKey: "welcomeText",
                title: "Bottom-Right Position",
                description: "Tooltips can be positioned at the bottom-right corner of any element.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottomTrailing(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "galleryTitle",
                title: "Top-Left Position",
                description: "This tooltip is positioned at the top-left. Great for corner placements!",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .topLeading(offset: 15),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "settingsIcon",
                title: "Automatic Positioning",
                description: "The tooltip automatically finds the best position based on available space. It will never overlap the highlighted element!",
                highlightShape: .circle,
                tooltipPosition: .automatic,
                showArrow: true
            ),
            TutorialStep(
                targetKey: "profileTitle",
                title: "Custom Content",
                description: "Tooltips can include custom views with images, buttons, and more.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottom(offset: 15),
                showArrow: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 10) {
                            HStack(spacing: 5) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            Text("Premium Feature")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                        }
                    )
                }
            ),
            TutorialStep(
                targetKey: "emailField",
                title: "No Arrow Style",
                description: "This step demonstrates a tooltip without an arrow. Sometimes less is more!",
                highlightShape: .roundedRect(cornerRadius: 6),
                tooltipPosition: .top(offset: 15),
                showArrow: false
            ),
            TutorialStep(
                targetKey: "basicTourButton",
                title: "Circle Highlight",
                description: "Different highlight shapes are available: circle, rectangle, and rounded rectangle.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "showcaseButton",
                title: "Tutorial Complete! 🎉",
                description: "You've seen all the major features: different positions, shapes, arrows, and custom content. Try the other tutorials to see more!",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            Text("✨ Features Covered ✨")
                                .font(.caption)
                                .fontWeight(.bold)
                            HStack(spacing: 15) {
                                Label("Positions", systemImage: "arrow.up.left.and.arrow.down.right")
                                Label("Shapes", systemImage: "circle.square")
                                Label("Arrows", systemImage: "arrow.right")
                            }
                            .font(.caption2)
                        }
                        .foregroundColor(.purple)
                    )
                }
            )
        ]

        let flow = TutorialFlow(
            name: "Feature Showcase",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .doubleTap,
            onComplete: {
                print("✅ Feature showcase completed!")
            },
            onSkip: {
                print("⏭️ Feature showcase skipped!")
            }
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Gallery Items Tutorial
    static func galleryItemsTutorial(coordinator: TutorialCoordinator) {
        let galleryIcons = ["photo", "camera", "video", "music.note", "book"]
        let galleryTitles = ["Photos", "Camera", "Videos", "Music", "Books"]
        let galleryDescriptions = [
            "Browse through your photo collection. Tap to view full-size images.",
            "Open the camera to capture new moments instantly.",
            "Watch your video library. All your recorded clips in one place.",
            "Listen to your music collection. Explore playlists and albums.",
            "Access your digital book library. Continue reading where you left off."
        ]

        var steps: [TutorialStep] = [
            TutorialStep(
                targetKey: "galleryTitle",
                title: "Gallery Overview",
                description: "This gallery contains different media types. Let's explore each one!",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottom(offset: 15),
                showArrow: true
            )
        ]

        for index in 0..<5 {
            steps.append(
                TutorialStep(
                    targetKey: "galleryItem\(index)",
                    title: galleryTitles[index],
                    description: galleryDescriptions[index],
                    highlightShape: .roundedRect(cornerRadius: 12),
                    tooltipPosition: .bottom(offset: 15),
                    showArrow: true,
                    customContent: {
                        AnyView(
                            HStack(spacing: 5) {
                                Image(systemName: galleryIcons[index])
                                    .foregroundColor(.purple)
                                Text("Item \(index + 1) of 5")
                                    .font(.caption)
                                    .foregroundColor(.purple)
                            }
                        )
                    }
                )
            )
        }

        let flow = TutorialFlow(
            name: "Gallery Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print("✅ Gallery tutorial completed!")
            },
            onSkip: {
                print("⏭️ Gallery tutorial skipped!")
            }
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Customization Demo
    static func customizationDemo(coordinator: TutorialCoordinator) {
        let steps = [
            TutorialStep(
                targetKey: "header",
                title: "Global Styling Example",
                description: "This tutorial uses custom global styling for all tooltips (unless overridden per step). Notice the blue background and different shadows!",
                highlightShape: .roundedRect(cornerRadius: 15),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Per-Step Tooltip Override",
                description: "This step overrides the global tooltip style with extreme corner radius (100) and pink background!",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    backgroundColor: Color(red: 1.0, green: 0.75, blue: 0.8),
                    cornerRadius: 100,
                    shadowColor: .purple,
                    shadowOpacity: 0.4,
                    shadowRadius: 15,
                    shadowX: 5,
                    shadowY: 10
                )
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Sharp Corners & No Shadow",
                description: "This tooltip has zero corner radius (sharp corners) and no shadow!",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    backgroundColor: Color(red: 0.9, green: 1.0, blue: 0.9),
                    cornerRadius: 0,
                    shadowColor: .clear,
                    shadowOpacity: 0,
                    shadowRadius: 0,
                    shadowX: 0,
                    shadowY: 0
                )
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Custom Blur/Dim",
                description: "This step has a custom blue dim overlay with low opacity instead of the default black!",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                blurStyle: BlurStyle(
                    dimColor: .blue,
                    dimOpacity: 0.3
                )
            ),
            TutorialStep(
                targetKey: "notificationBell",
                title: "Red Dim Overlay",
                description: "Each step can have its own blur style. This one uses a red tint!",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                blurStyle: BlurStyle(
                    dimColor: .red,
                    dimOpacity: 0.4
                )
            ),
            TutorialStep(
                targetKey: "imageGallery",
                title: "Back to Global Defaults",
                description: "This step doesn't specify custom styling, so it uses the global defaults (blue tooltip from the flow settings).",
                highlightShape: .roundedRect(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            )
        ]

        let flow = TutorialFlow(
            name: "Customization Demo",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print("✅ Customization demo completed!")
            },
            onSkip: {
                print("⏭️ Customization demo skipped!")
            },
            defaultTooltipStyle: TooltipStyle(
                backgroundColor: Color(red: 0.85, green: 0.95, blue: 1.0),
                cornerRadius: 20,
                shadowColor: .blue,
                shadowOpacity: 0.3,
                shadowRadius: 12,
                shadowX: 0,
                shadowY: 8
            ),
            defaultBlurStyle: BlurStyle(
                dimColor: .black,
                dimOpacity: 0.75
            )
        )

        coordinator.startFlow(flow)
    }
}
