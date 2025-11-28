//
//  TutorialFlows.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import Foundation
import GuidedTutorial
import SwiftUI

// Custom shape for demonstration
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

struct TutorialFlows {

    // MARK: - Main Tutorial
    static func basicTutorial(coordinator: TutorialCoordinator) {
        let steps = [
            TutorialStep(
                targetKey: "header",
                title: "Welcome! ",
                description: "This is the main header of the app. It shows your welcome message and quick access to notifications.",
                highlightShape: .roundedRect(cornerRadius: 15),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.draw")
                                    .foregroundColor(.blue)
                                Text("Swipe down anywhere to skip this tutorial")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    )
                }
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
            ),
            TutorialStep(
                targetKey: "imageGallery",
                title: "Swipe to Continue! ",
                description: "Notice there's NO 'Next' button below! The only way to proceed is to SWIPE RIGHT on the gallery. This forces users to perform specific actions.",
                highlightShape: .roundedRect(cornerRadius: 12),
                actionType: .swipe(direction: .right),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                blockOtherInteractions: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.point.left.fill")
                                    .foregroundColor(.orange)
                                    .font(.title3)
                                Text("Swipe RIGHT on the gallery")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                            Text("(This is the ONLY way to continue)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    )
                }
            ),
            TutorialStep(
                targetKey: "settingsTitle",
                title: "Settings Section (Auto-advance)",
                description: "Configure your app preferences here. This step auto-advances after 2 seconds.",
                highlightShape: .rectangle(cornerRadius: 8),
                actionType: .automatic(delay: 2.0),
                tooltipPosition: .bottom(offset: 15)
            ),
            TutorialStep(
                targetKey: "notificationsToggle",
                title: "Double Tap Required! ",
                description: "Again, no Next button! You must DOUBLE TAP anywhere on the screen to continue. Different action types can enforce different user interactions.",
                highlightShape: .roundedRect(cornerRadius: 8),
                actionType: .doubleTap,
                tooltipPosition: .top(offset: 15),
                blockOtherInteractions: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 5) {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.tap.fill")
                                    .foregroundColor(.purple)
                                    .font(.title3)
                                Text("Double tap anywhere to proceed")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.purple)
                            }
                        }
                    )
                }
            ),
            TutorialStep(
                targetKey: "darkModeToggle",
                title: "Long Press Action ",
                description: "One more forced action! PRESS AND HOLD anywhere for 1 second. Perfect for teaching gestures or confirming important actions.",
                highlightShape: .roundedRect(cornerRadius: 8),
                actionType: .longPress(duration: 1.0),
                tooltipPosition: .topTrailing(offset: 15),
                blockOtherInteractions: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 5) {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.press.fill")
                                    .foregroundColor(.green)
                                    .font(.title3)
                                Text("Press and hold for 1 second")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                        }
                    )
                }
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
            name: "Main Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print(" Main tutorial completed!")
            },
            onSkip: {
                print(" Main tutorial skipped!")
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
        let scrollAnimations: [ScrollAnimation] = [
            .easeInOut(duration: 0.5),
            .spring(response: 0.6, dampingFraction: 0.7),
            .easeOut(duration: 0.8),
            .interpolatingSpring(stiffness: 200, damping: 15),
            .linear(duration: 0.4)
        ]
        let animationDescriptions = [
            "EaseInOut",
            "Spring",
            "EaseOut",
            "Interpolating Spring",
            "Linear"
        ]

        var steps: [TutorialStep] = [
            TutorialStep(
                targetKey: "galleryTitle",
                title: "Gallery Overview + Scroll Animation Showcase",
                description: "This gallery demonstrates different scroll animations! Each item uses a unique animation style when scrolling to it.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottom(offset: 15),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundColor(.blue)
                                Text("Watch the scroll animation!")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    )
                }
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
                            VStack(spacing: 8) {
                                HStack(spacing: 5) {
                                    Image(systemName: galleryIcons[index])
                                        .foregroundColor(.purple)
                                    Text("Item \(index + 1) of 5")
                                        .font(.caption)
                                        .foregroundColor(.purple)
                                }
                                HStack(spacing: 5) {
                                    Image(systemName: "arrow.up.arrow.down")
                                        .foregroundColor(.orange)
                                        .font(.caption2)
                                    Text("Animation: \(animationDescriptions[index])")
                                        .font(.caption2)
                                        .foregroundColor(.orange)
                                }
                            }
                        )
                    },
                    scrollAnimation: scrollAnimations[index]
                )
            )
        }

        let flow = TutorialFlow(
            name: "Gallery Tour",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print(" Gallery tutorial completed!")
            },
            onSkip: {
                print(" Gallery tutorial skipped!")
            },
            scrollAnimation: .easeInOut(duration: 0.5)
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
                title: "Custom Diamond Shape",
                description: "You can even use CUSTOM SHAPES! This uses a custom diamond/rhombus shape instead of rectangle or circle.",
                highlightShape: .custom(path: { Diamond() }),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "usernameField",
                title: "Back to Global Defaults",
                description: "This step uses the flow's default styling - warm earth tones with custom serif fonts throughout.",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true
            ),
            TutorialStep(
                targetKey: "saveButton",
                title: "Button Customization",
                description: "You can also customize buttons! This step has custom button text.",
                highlightShape: .roundedRect(cornerRadius: 8),
                tooltipPosition: .top(offset: 15),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    buttonStyle: TooltipButtonStyle(
                        nextButtonText: "Continue →",
                        skipButtonText: "Exit Tutorial"
                    )
                )
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Custom Button Colors",
                description: "Buttons can have custom colors! This step uses a green 'Next' button and a red 'Skip' button.",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    buttonStyle: TooltipButtonStyle(
                        nextButtonText: "Got it!",
                        skipButtonText: "Cancel",
                        nextButtonColor: .green,
                        skipButtonColor: .red
                    )
                )
            ),
            TutorialStep(
                targetKey: "plusButton",
                title: "Vertical Button Layout",
                description: "Buttons can be arranged vertically instead of horizontally. See how the buttons stack below?",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    buttonStyle: TooltipButtonStyle(
                        nextButtonText: "Next Step",
                        skipButtonText: "Skip",
                        buttonLayout: .vertical
                    )
                )
            ),
            TutorialStep(
                targetKey: "minusButton",
                title: "Custom Button Styles",
                description: "Mix and match button styles! This step has a prominent 'Next' and a bordered 'Skip' button.",
                highlightShape: .circle,
                tooltipPosition: .top(offset: 20),
                showArrow: true,
                tooltipStyle: TooltipStyle(
                    buttonStyle: TooltipButtonStyle(
                        nextButtonText: "Proceed",
                        skipButtonText: "Go Back",
                        nextButtonColor: .purple,
                        skipButtonColor: .orange,
                        nextButtonStyle: .borderedProminent,
                        skipButtonStyle: .bordered
                    )
                )
            ),
            TutorialStep(
                targetKey: "imageGallery",
                title: "Custom Action Buttons!",
                description: "You can add CUSTOM BUTTONS with their own actions! This step has 3 custom buttons instead of Next/Skip.",
                highlightShape: .roundedRect(cornerRadius: 12),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            Text(" Try the buttons below ")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                        }
                    )
                },
                tooltipStyle: TooltipStyle(
                    buttonStyle: TooltipButtonStyle(
                        buttonLayout: .vertical,
                        customButtons: [
                            CustomButton(
                                text: "Continue Tutorial",
                                action: {
                                    Task { @MainActor in
                                        coordinator.nextStep()
                                    }
                                },
                                color: .green,
                                style: .borderedProminent
                            ),
                            CustomButton(
                                text: "Learn More",
                                action: { print(" Learn More tapped!") },
                                color: .blue,
                                style: .bordered
                            ),
                            CustomButton(
                                text: "Skip Tutorial",
                                action: {
                                    Task { @MainActor in
                                        coordinator.skipTutorial()
                                    }
                                },
                                color: .red,
                                style: .plain
                            )
                        ]
                    )
                )
            ),
            TutorialStep(
                targetKey: "profileTitle",
                title: "Mix & Match Everything!",
                description: "You can customize everything: tooltips, arrows, buttons, colors, fonts, shapes, and more. Mix any combination to match your app's design!",
                highlightShape: .rectangle(cornerRadius: 8),
                tooltipPosition: .bottom(offset: 20),
                showArrow: true,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            Text(" Customization Options ")
                                .font(.caption)
                                .fontWeight(.bold)
                            HStack(spacing: 12) {
                                Label("Styles", systemImage: "paintbrush")
                                Label("Arrows", systemImage: "arrow.right")
                                Label("Buttons", systemImage: "hand.tap")
                            }
                            .font(.caption2)
                        }
                        .foregroundColor(.blue)
                    )
                },
                tooltipStyle: TooltipStyle(
                    buttonStyle: TooltipButtonStyle(
                        nextButtonText: "Awesome!",
                        skipButtonText: "Leave",
                        nextButtonColor: .blue,
                        skipButtonColor: .gray,
                        nextButtonStyle: .borderedProminent,
                        skipButtonStyle: .plain
                    )
                )
            )
        ]

        let flow = TutorialFlow(
            name: "Customization Demo",
            steps: steps,
            canBeSkipped: true,
            skipGesture: .swipeDown,
            onComplete: {
                print(" Customization demo completed!")
            },
            onSkip: {
                print(" Customization demo skipped!")
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
                title: "Automatic Validation ",
                description: "The framework AUTOMATICALLY validates accessibility in DEBUG mode! Check your console for warnings. This tooltip has good contrast.",
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
                            Text("Ratio: 21:1 (Perfect!)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    )
                },
                tooltipStyle: TooltipStyle(
                    backgroundColor: .white,
                    cornerRadius: 12,
                    titleColor: .black,
                    descriptionColor: .black,
                )
            ),
            TutorialStep(
                targetKey: "counter",
                title: "Low Contrast Warning ",
                description: "This step intentionally uses poor contrast. In DEBUG builds, you'll see a warning in the console about this!",
                highlightShape: .circle,
                tooltipPosition: .bottom(offset: 20),
                showArrow: false,
                customContent: {
                    AnyView(
                        VStack(spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                Text("Low Contrast Example")
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            Text("Check your console for the warning!")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    )
                },
                tooltipStyle: TooltipStyle(
                    backgroundColor: Color(red: 1.0, green: 1.0, blue: 0.9),
                    cornerRadius: 12,
                    titleColor: Color(red: 1.0, green: 0.9, blue: 0.5),
                    descriptionColor: Color(red: 1.0, green: 0.85, blue: 0.4)
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
                print(" Accessibility demo completed!")
            },
            onSkip: {
                print(" Accessibility demo skipped!")
            }
        )

        coordinator.startFlow(flow)
    }
}
