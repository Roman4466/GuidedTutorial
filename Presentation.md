# GuidedTutorial
## SwiftUI Framework for Interactive Tutorials

**Roman Malynovsky**

---

# Problem

- Onboarding new users is challenging
- Users often miss important features
- Traditional tutorials are boring and static
- Building custom tutorial systems is time-consuming

---

# Solution: GuidedTutorial

A SwiftUI framework that makes it easy to create:

- Interactive step-by-step tutorials
- Spotlight overlays highlighting UI elements
- Customizable tooltips with various positions
- Support for different gestures (tap, swipe, long press)

---

# Key Features

- **Spotlight Overlays** - Circle, rectangle, rounded rect, capsule, custom shapes
- **Smart Tooltips** - 10 positioning options + automatic
- **Multiple Actions** - Tap, swipe, double tap, long press
- **Auto-Scroll** - Automatically scrolls to off-screen targets
- **Blur Effects** - Customizable background blur
- **Accessibility** - WCAG 2.1 color contrast validation
- **Full Customization** - Colors, fonts, buttons, styles

---

# Installation

**Swift Package Manager:**
```swift
.package(url: "https://github.com/Roman4466/GuidedTutorial.git",
         from: "1.0.0")
```

**CocoaPods:**
```ruby
pod 'GuidedTutorial', '~> 1.0'
```

---

# Usage Example

```swift
// 1. Create coordinator
@StateObject var coordinator = TutorialCoordinator()

// 2. Mark targets
Button("Start")
    .tutorialTarget("startButton", coordinator: coordinator)

// 3. Add overlay
ContentView()
    .tutorialOverlay(coordinator: coordinator)

// 4. Start tutorial
coordinator.startFlow(myTutorialFlow)
```

---

# Creating a Tutorial Flow

```swift
let steps = [
    TutorialStep(
        targetKey: "startButton",
        title: "Welcome!",
        description: "Tap here to begin.",
        highlightShape: .circle,
        tooltipPosition: .bottom(offset: 10)
    )
]

let flow = TutorialFlow(
    name: "Onboarding",
    steps: steps,
    canBeSkipped: true
)
```

---

# Architecture

```
GuidedTutorial/
├── Coordinator/
│   └── TutorialCoordinator.swift
├── Models/
│   ├── TutorialFlow.swift
│   ├── TutorialStep.swift
│   └── TooltipStyle.swift
├── Views/
│   ├── TooltipView.swift
│   ├── SpotlightOverlay.swift
│   └── ArrowView.swift
└── ViewModifiers/
    └── TutorialTargetModifier.swift
```

---

# Development Experience

**Challenges:**
- SwiftUI gesture conflicts resolution
- Accurate frame capture using PreferenceKey
- Main actor isolation in Swift 6

**Tools Used:**
- Swift Package Manager + CocoaPods
- SwiftLint for code quality
- WCAG validation for accessibility

---

# Demo

**Live demonstration of the framework**

- Basic tutorial flow
- Different highlight shapes
- Swipe gestures
- Custom styling

---

# Thank You!

**Repository:** github.com/Roman4466/GuidedTutorial

**CocoaPods:** cocoapods.org/pods/GuidedTutorial

**Questions?**
