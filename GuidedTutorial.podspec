Pod::Spec.new do |s|
  s.name             = 'GuidedTutorial'
  s.version          = '1.0.0'
  s.summary          = 'A SwiftUI framework for creating interactive guided tutorials with tooltips, spotlights, and gestures.'

  s.description      = <<-DESC
    GuidedTutorial is a powerful SwiftUI framework that helps you create
    interactive onboarding experiences and guided tutorials for your iOS apps.

    Features:
    - Customizable tooltips with various positions and styles
    - Spotlight overlays with different shapes (circle, rectangle, rounded rect, capsule)
    - Arrow indicators pointing to target elements
    - Support for various action types (tap, swipe, double tap, long press)
    - Automatic scrolling to tutorial targets
    - Skip gestures for entire tutorials
    - WCAG 2.1 accessibility validation
    - Full customization of colors, fonts, and button styles
  DESC

  s.homepage         = 'https://github.com/Roman4466/GuidedTutorial'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Roman Malynovsky' => 'roman@example.com' }
  s.source           = { :git => 'https://github.com/Roman4466/GuidedTutorial.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.9'

  s.source_files = 'Sources/GuidedTutorial/**/*.swift'

  s.frameworks = 'SwiftUI', 'Combine'
end
