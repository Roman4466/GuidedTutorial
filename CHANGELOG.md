# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-XX

### Added
- Initial public release
- Customizable tooltips with 10 positioning options (top, bottom, leading, trailing, corners, center, automatic)
- Spotlight overlays with 4 highlight shapes (circle, rectangle, rounded rectangle, capsule, custom)
- Support for 6 action types (tap, swipe in all directions, double tap, long press, automatic advancement, custom)
- Automatic scrolling to tutorial targets
- Skip gesture support (swipe down, swipe up, long press)
- Blur effects with customizable radius and opacity
- Arrow indicators with curved animation
- Full button customization (colors, styles, layouts, custom buttons array)
- WCAG 2.1 accessibility validation with automatic color contrast checking
- Comprehensive demo app with 7 tutorial flows
- Swift Package Manager support
- CocoaPods support
- Complete API documentation
- SwiftLint integration

### Features
- TutorialCoordinator for managing tutorial flows
- TutorialFlow for defining multi-step tutorials
- TutorialStep with extensive customization options
- Automatic frame capture using PreferenceKey
- Event system for tracking tutorial progress
- Main actor isolation for thread safety
- Sendable protocol conformance for Swift 6 concurrency
- Custom content support in tooltips
- Per-step and per-flow style customization

[1.0.0]: https://github.com/Roman4466/GuidedTutorial/releases/tag/1.0.0
