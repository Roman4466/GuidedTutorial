# GuidedTutorial

A SwiftUI framework for creating interactive guided tutorials with tooltips, spotlights, and gestures.

## Features

- **Customizable Tooltips** - Various positions (top, bottom, leading, trailing, corners, center, automatic) with full style customization
- **Spotlight Overlays** - Highlight UI elements with different shapes (circle, rectangle, rounded rectangle, capsule, custom)
- **Arrow Indicators** - Animated arrows pointing from tooltip to target element
- **Multiple Action Types** - Support for tap, swipe (all directions), double tap, and long press gestures
- **Automatic Scrolling** - Automatically scrolls to off-screen tutorial targets
- **Skip Gestures** - Allow users to skip tutorials with swipe or long press gestures
- **Blur Effects** - Customizable background blur with adjustable radius and opacity
- **Button Customization** - Full control over tooltip button styles, colors, and layouts
- **Accessibility** - Built-in WCAG 2.1 color contrast validation
- **Step-by-Step Flow** - Manage multi-step tutorial flows with callbacks

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Roman4466/GuidedTutorial.git", from: "1.0.0")
]
```

Or in Xcode: File > Add Package Dependencies > Enter the repository URL.

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'GuidedTutorial', '~> 1.0'
```

Then run:

```bash
pod install
```

## Quick Start

### 1. Import the framework

```swift
import GuidedTutorial
```

### 2. Create a TutorialCoordinator

```swift
@StateObject private var tutorialCoordinator = TutorialCoordinator()
```

### 3. Mark tutorial targets

```swift
Button("Get Started") {
    // action
}
.tutorialTarget("getStartedButton", coordinator: tutorialCoordinator)
```

### 4. Add the tutorial overlay

```swift
var body: some View {
    YourContentView()
        .tutorialOverlay(coordinator: tutorialCoordinator)
}
```

### 5. Define and start a tutorial flow

```swift
func startTutorial() {
    let steps = [
        TutorialStep(
            targetKey: "getStartedButton",
            title: "Welcome!",
            description: "Tap this button to get started.",
            tooltipPosition: .top(offset: 10)
        ),
        TutorialStep(
            targetKey: "settingsButton",
            title: "Settings",
            description: "Configure your preferences here.",
            highlightShape: .circle,
            tooltipPosition: .bottom(offset: 10)
        )
    ]

    let flow = TutorialFlow(
        name: "Onboarding",
        steps: steps,
        canBeSkipped: true,
        skipGesture: .swipeDown,
        onComplete: {
            print("Tutorial completed!")
        }
    )

    tutorialCoordinator.startFlow(flow)
}
```

## Customization

### Tooltip Styles

```swift
let customStyle = TooltipStyle(
    backgroundColor: .blue,
    titleColor: .white,
    descriptionColor: .white.opacity(0.9),
    cornerRadius: 16,
    padding: 20,
    titleFont: .headline,
    descriptionFont: .subheadline,
    maxWidth: 300
)

TutorialStep(
    targetKey: "myButton",
    title: "Custom Style",
    description: "This tooltip has a custom style.",
    tooltipStyle: customStyle
)
```

### Highlight Shapes

```swift
// Available shapes
.circle
.rectangle(padding: 8)
.roundedRect(cornerRadius: 12, padding: 8)
.capsule(padding: 4)
.custom(path: { rect in /* custom Path */ })
```

### Action Types

```swift
// Tap (default)
actionType: .tap

// Swipe in any direction
actionType: .swipe(direction: .right)
actionType: .swipe(direction: .left)
actionType: .swipe(direction: .up)
actionType: .swipe(direction: .down)

// Double tap
actionType: .doubleTap

// Long press with custom duration
actionType: .longPress(duration: 1.5)

// Automatic advancement
actionType: .automatic(delay: 3.0)
```

### Tooltip Positions

```swift
.top(offset: 10)
.bottom(offset: 10)
.leading(offset: 10)
.trailing(offset: 10)
.topLeading(offset: 10)
.topTrailing(offset: 10)
.bottomLeading(offset: 10)
.bottomTrailing(offset: 10)
.center
.automatic  // Automatically determines best position
```

### Blur Styles

```swift
let blurStyle = BlurStyle(
    radius: 10,
    opacity: 0.8,
    animated: true
)

TutorialStep(
    targetKey: "myElement",
    title: "With Blur",
    description: "Background is blurred.",
    blurStyle: blurStyle
)
```

### Arrow Styles

```swift
let arrowStyle = ArrowStyle(
    color: .orange,
    lineWidth: 3,
    headLength: 15,
    animated: true
)

TutorialStep(
    targetKey: "myElement",
    title: "Custom Arrow",
    description: "With styled arrow.",
    showArrow: true,
    arrowStyle: arrowStyle
)
```

## Automatic Scrolling

The framework automatically scrolls to tutorial targets. To enable this:

```swift
ScrollViewReader { scrollProxy in
    ScrollView {
        // Your content
    }
    .onAppear {
        tutorialCoordinator.registerScrollProxy(scrollProxy)
    }
}
```

You can configure scrolling behavior:

```swift
tutorialCoordinator.autoScrollEnabled = true
tutorialCoordinator.scrollAnimationDuration = 0.5
```

## Event Handling

Listen to tutorial events:

```swift
tutorialCoordinator.addEventHandler { event in
    switch event {
    case .tutorialStarted:
        print("Tutorial started")
    case .tutorialCompleted:
        print("Tutorial completed")
    case .tutorialSkipped:
        print("Tutorial skipped")
    case .stepStarted(let stepId):
        print("Step started: \(stepId)")
    case .stepCompleted(let stepId):
        print("Step completed: \(stepId)")
    case .stepSkipped(let stepId):
        print("Step skipped: \(stepId)")
    }
}
```

## Programmatic Control

```swift
// Move to next step
tutorialCoordinator.nextStep()

// Skip to specific step by index
tutorialCoordinator.skipToStep(index: 2)

// Skip to specific step by ID
tutorialCoordinator.skipToStep(id: stepUUID)

// Skip entire tutorial
tutorialCoordinator.skipTutorial()

// Complete tutorial
tutorialCoordinator.completeTutorial()
```

## Accessibility

The framework includes WCAG 2.1 color contrast validation. Enable validation in DEBUG builds:

```swift
let flow = TutorialFlow(
    name: "My Tutorial",
    steps: steps,
    validateAccessibility: true  // Validates contrast ratios
)
```

## Example App

Check the `Example/` folder for a complete example app demonstrating all features.

## License

MIT License. See [LICENSE](LICENSE) for details.

## Author

Roman Malynovsky - roman.malynovsky@gmail.com
