# Slide 1: Title

**GuidedTutorial**
SwiftUI Framework for Interactive Tutorials

Roman Malynovsky

---

# Slide 2: Problem

**Why This Framework?**

- Users often miss important app features
- Traditional onboarding is static and boring
- Building custom tutorial systems takes weeks
- No good SwiftUI-native solutions exist

**Solution:** Easy-to-use framework for interactive tutorials

---

# Slide 3: Key Features

**What Can It Do?**

- **Spotlight Overlays** - Highlight any UI element with custom shapes
- **Smart Tooltips** - 10 positioning options + automatic placement
- **Multiple Actions** - Tap, swipe, double tap, long press
- **Auto-Scroll** - Automatically scrolls to tutorial targets
- **Full Customization** - Colors, fonts, buttons, animations
- **Accessibility** - WCAG 2.1 color contrast validation built-in

---

# Slide 4: How to Use

**Just 4 Steps:**

1. Create coordinator:
   `@StateObject var coordinator = TutorialCoordinator()`

2. Mark targets:
   `Button("Start").tutorialTarget("startButton", coordinator: coordinator)`

3. Add overlay:
   `ContentView().tutorialOverlay(coordinator: coordinator)`

4. Start tutorial:
   `coordinator.startFlow(myTutorialFlow)`

**That's it!**

---

# Slide 5: Architecture & Tech Stack

**Built With:**
- Swift 6.0 with @MainActor and Sendable
- SwiftUI-native (PreferenceKey, GeometryReader)
- Clean architecture (Coordinator pattern)

**Distribution:**
- Swift Package Manager ✓
- CocoaPods ✓
- Open source (MIT License)

**Code Quality:**
- SwiftLint: 0 violations
- Comprehensive documentation
- Example app with 7 tutorials

---

# Slide 6: Live Demo & Resources

**What You'll See:**
- Basic tutorial flow
- Different action types (swipe, tap, long press)
- Custom styling and positions
- Accessibility validation

**Get It:**
- GitHub: github.com/Roman4466/GuidedTutorial
- CocoaPods: `pod 'GuidedTutorial'`

**Questions?**
