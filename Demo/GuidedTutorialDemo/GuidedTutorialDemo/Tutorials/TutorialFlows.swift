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
                description: "This tutorial uses custom global styling for all tooltips (unless overridden per step). Notice the warm earth-toned background and serif fonts!",
                highlightShape: .roundedRect(cornerRadius: 15),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Custom Fonts & Colors",
                description: "This step showcases custom fonts! The title uses a rounded design font and the description uses a monospaced font.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    backgroundColor: Color(red: 0.95, green: 0.92, blue: 0.88),
                    cornerRadius: 20,
                    shadowColor: Color(red: 0.7, green: 0.5, blue: 0.3),
                    shadowOpacity: 0.3,
                    shadowRadius: 15,
                    shadowX: 0,
                    shadowY: 8,
                    titleFont: .system(.title3, design: .rounded, weight: .bold),
                    titleColor: Color(red: 0.6, green: 0.4, blue: 0.2),
                    descriptionFont: .system(.body, design: .monospaced),
                    descriptionColor: Color(red: 0.5, green: 0.4, blue: 0.3)
                )
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Custom Arrow Style",
                description: "Notice the thick orange arrow with larger arrowhead? Arrows are fully customizable: color, width, arrowhead size and angle!",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                arrowStyle: ArrowStyle(
                    color: Color(red: 0.9, green: 0.5, blue: 0.2),
                    lineWidth: 5,
                    arrowheadLength: 15,
                    arrowheadAngle: 40,
                    animationDuration: 1.0
                )
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Curved Arrow",
                description: "The curve intensity can be adjusted! This arrow has 2x curve intensity for a dramatic swoosh effect.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                arrowStyle: ArrowStyle(
                    color: Color(red: 0.4, green: 0.6, blue: 0.5),
                    lineWidth: 4,
                    animationDuration: 0.4,
                    curveIntensity: 2.0
                )
            ),
            TutorialStep(
                targetKey: "notificationBell",
                title: "No Animation Arrow",
                description: "Arrows can have animation disabled for a static appearance. This green arrow stays solid.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                blurStyle: BlurStyle(
                    dimColor: Color(red: 0.5, green: 0.6, blue: 0.4),
                    dimOpacity: 0.3
                ),
                arrowStyle: ArrowStyle(
                    color: Color(red: 0.5, green: 0.7, blue: 0.4),
                    lineWidth: 3,
                    animationEnabled: false
                )
            ),
            TutorialStep(
                targetKey: "imageGallery",
                title: "Custom Padding & Spacing",
                description: "Even internal tooltip spacing and padding is customizable! This tooltip has extra padding and spacing for a more spacious feel.",
                highlightShape: .roundedRect(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    backgroundColor: Color(red: 0.92, green: 0.88, blue: 0.82),
                    cornerRadius: 16,
                    padding: 24,
                    spacing: 16
                )
            ),
            TutorialStep(
                targetKey: "settingsTitle",
                title: "Back to Global Defaults",
                description: "This step uses the flow's default styling - warm earth tones with custom serif fonts throughout.",
                highlightShape: .rectangle(cornerRadius: 8),
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
                backgroundColor: Color(red: 0.95, green: 0.92, blue: 0.88),
                cornerRadius: 16,
                shadowColor: Color(red: 0.6, green: 0.5, blue: 0.4),
                shadowOpacity: 0.25,
                shadowRadius: 10,
                shadowX: 0,
                shadowY: 6,
                titleFont: .system(.headline, design: .serif),
                titleColor: Color(red: 0.5, green: 0.4, blue: 0.3),
                descriptionFont: .system(.body, design: .serif),
                descriptionColor: Color(red: 0.6, green: 0.5, blue: 0.4)
            ),
            defaultBlurStyle: BlurStyle(
                dimColor: Color(red: 0.4, green: 0.3, blue: 0.2),
                dimOpacity: 0.6
            ),
            defaultArrowStyle: ArrowStyle(
                color: Color(red: 0.7, green: 0.5, blue: 0.3),
                lineWidth: 3,
                arrowheadLength: 12,
                animationDuration: 0.7
            )
        )

        coordinator.startFlow(flow)
    }

    // MARK: - Accessibility Demo
    static func accessibilityDemo(coordinator: TutorialCoordinator) {
        let steps = [
            TutorialStep(
                targetKey: "header",
                title: "Accessibility Features",
                description: "This tutorial demonstrates the accessibility features built into GuidedTutorial. Try using VoiceOver, Dynamic Type, or Reduce Motion to see them in action!",
                highlightShape: .roundedRect(cornerRadius: 15),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "counter",
                title: "VoiceOver Support",
                description: "All tooltips have proper accessibility labels and hints. Enable VoiceOver (triple-click home/side button) to hear the tutorial content read aloud.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Dynamic Type Support",
                description: "Go to Settings > Accessibility > Display & Text Size > Larger Text to test. The tooltips will automatically resize to accommodate larger text sizes!",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Reduced Motion",
                description: "Enable Settings > Accessibility > Motion > Reduce Motion. The arrow animations will be disabled, and step transitions will be instant instead of animated.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "notificationBell",
                title: "Color Contrast Validation",
                description: "The framework includes built-in WCAG color contrast validation helpers to ensure your tooltips are readable for users with visual impairments.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("WCAG AA Compliant")
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            Text("Use TooltipStyle.validateAccessibility() to check")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    )
                },
                tooltipStyle: TooltipStyle(
                    backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.95),
                    cornerRadius: 12
                )
            ),
            TutorialStep(
                targetKey: "imageGallery",
                title: "Accessible by Default",
                description: "All accessibility features work automatically - no extra code needed! The framework handles VoiceOver, Dynamic Type, and Reduced Motion out of the box.",
                highlightShape: .roundedRect(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            )
        ]

        let flow = TutorialFlow(
            name: "Accessibility Demo",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print("✅ Accessibility demo completed!")
            },
            onSkip: {
                print("⏭️ Accessibility demo skipped!")
            }
        )

        coordinator.startFlow(flow)
    }
}
