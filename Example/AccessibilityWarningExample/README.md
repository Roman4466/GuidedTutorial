# Accessibility Warning Example

Demonstrates WCAG 2.1 color contrast validation warnings.

## What It Shows

- How the framework validates accessibility in DEBUG mode
- What happens when colors don't meet WCAG AA standards
- Console warnings for poor color contrast

## How to Run

From this directory:

```bash
swift run
```

Or open in Xcode and run in DEBUG mode.

## What to Look For

When you tap "Show Bad Contrast Tutorial", check:

1. **Xcode Console** - You'll see warnings like:
   ```
   ⚠️ Accessibility Warning in 'Bad Contrast Tutorial' step 1:
     - Title color contrast ratio 1.2:1 is below WCAG AA standard (4.5:1 required)
     - Description color contrast ratio 1.5:1 is below WCAG AA standard (4.5:1 required)
   ```

2. **In-App Display** - The console output is also shown in the UI for demonstration

## WCAG Standards

The framework validates:
- **WCAG AA**: Contrast ratio ≥ 4.5:1 (normal text)
- **WCAG AA**: Contrast ratio ≥ 3.0:1 (large text ≥18pt)
- **WCAG AAA**: Contrast ratio ≥ 7.0:1 (normal text)
- **WCAG AAA**: Contrast ratio ≥ 4.5:1 (large text)

## Code Highlights

```swift
// Bad contrast example
let badStyle = TooltipStyle(
    backgroundColor: .white,
    titleColor: Color(red: 0.8, green: 0.8, blue: 0.8), // Light gray on white - BAD!
    descriptionColor: Color(red: 0.7, green: 0.7, blue: 0.7) // Light gray on white - BAD!
)

// Enable validation (on by default in DEBUG)
let flow = TutorialFlow(
    name: "Tutorial",
    steps: [step],
    validateAccessibility: true // Framework will print warnings
)
```

## Note

Validation only runs in DEBUG builds. In RELEASE builds, no performance overhead is added.
