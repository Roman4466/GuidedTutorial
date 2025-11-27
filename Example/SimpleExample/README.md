# Simple Example

The simplest possible integration of GuidedTutorial framework.

## What It Shows

- One button
- One tooltip
- Minimal setup code

## How to Run

From this directory:

```bash
swift run
```

Or open in Xcode and run.

## Code Highlights

```swift
// 1. Create coordinator
@StateObject private var coordinator = TutorialCoordinator()

// 2. Mark target
Button("Start Tutorial") { }
    .tutorialTarget("startButton", coordinator: coordinator)

// 3. Add overlay
.tutorialOverlay(coordinator: coordinator)

// 4. Start tutorial
let step = TutorialStep(
    targetKey: "startButton",
    title: "Welcome!",
    description: "This is your first tutorial.",
    tooltipPosition: .bottom(offset: 20)
)

let flow = TutorialFlow(
    name: "Simple Tutorial",
    steps: [step]
)

coordinator.startFlow(flow)
```

That's all you need!
