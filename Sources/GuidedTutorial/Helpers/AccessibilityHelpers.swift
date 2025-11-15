//
//  AccessibilityHelpers.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 09.11.2025.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Accessibility helpers for the GuidedTutorial framework
public struct AccessibilityHelpers {

    /// Calculates the relative luminance of a color according to WCAG 2.1
    /// - Parameter color: The color to calculate luminance for
    /// - Returns: Luminance value between 0 and 1
    public static func relativeLuminance(of color: Color) -> Double {
        #if canImport(UIKit)
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let r = red <= 0.03928 ? red / 12.92 : pow((red + 0.055) / 1.055, 2.4)
        let g = green <= 0.03928 ? green / 12.92 : pow((green + 0.055) / 1.055, 2.4)
        let b = blue <= 0.03928 ? blue / 12.92 : pow((blue + 0.055) / 1.055, 2.4)

        return 0.2126 * r + 0.7152 * g + 0.0722 * b
        #elseif canImport(AppKit)
        let nsColor = NSColor(color)
        guard let rgbColor = nsColor.usingColorSpace(.deviceRGB) else { return 0 }

        let red = rgbColor.redComponent
        let green = rgbColor.greenComponent
        let blue = rgbColor.blueComponent

        let r = red <= 0.03928 ? red / 12.92 : pow((red + 0.055) / 1.055, 2.4)
        let g = green <= 0.03928 ? green / 12.92 : pow((green + 0.055) / 1.055, 2.4)
        let b = blue <= 0.03928 ? blue / 12.92 : pow((blue + 0.055) / 1.055, 2.4)

        return 0.2126 * r + 0.7152 * g + 0.0722 * b
        #else
        return 0
        #endif
    }

    /// Calculates the contrast ratio between two colors according to WCAG 2.1
    /// - Parameters:
    ///   - foreground: The foreground color (text color)
    ///   - background: The background color
    /// - Returns: Contrast ratio between 1 and 21
    public static func contrastRatio(between foreground: Color, and background: Color) -> Double {
        let l1 = relativeLuminance(of: foreground)
        let l2 = relativeLuminance(of: background)

        let lighter = max(l1, l2)
        let darker = min(l1, l2)

        return (lighter + 0.05) / (darker + 0.05)
    }

    /// Checks if the contrast ratio meets WCAG AA standards (4.5:1 for normal text, 3:1 for large text)
    /// - Parameters:
    ///   - foreground: The foreground color (text color)
    ///   - background: The background color
    ///   - isLargeText: Whether the text is considered large (18pt+ regular or 14pt+ bold)
    /// - Returns: True if the contrast meets WCAG AA standards
    public static func meetsWCAGAA(foreground: Color, background: Color, isLargeText: Bool = false) -> Bool {
        let ratio = contrastRatio(between: foreground, and: background)
        let requiredRatio = isLargeText ? 3.0 : 4.5
        return ratio >= requiredRatio
    }

    /// Checks if the contrast ratio meets WCAG AAA standards (7:1 for normal text, 4.5:1 for large text)
    /// - Parameters:
    ///   - foreground: The foreground color (text color)
    ///   - background: The background color
    ///   - isLargeText: Whether the text is considered large (18pt+ regular or 14pt+ bold)
    /// - Returns: True if the contrast meets WCAG AAA standards
    public static func meetsWCAGAAA(foreground: Color, background: Color, isLargeText: Bool = false) -> Bool {
        let ratio = contrastRatio(between: foreground, and: background)
        let requiredRatio = isLargeText ? 4.5 : 7.0
        return ratio >= requiredRatio
    }

    /// Validates a TooltipStyle for accessibility compliance
    /// - Parameter style: The tooltip style to validate
    /// - Returns: Array of accessibility warnings (empty if no issues)
    public static func validateTooltipStyle(_ style: TooltipStyle) -> [String] {
        var warnings: [String] = []

        // Check contrast between background and common text colors
        let primaryTextContrast = contrastRatio(between: .primary, and: style.backgroundColor)
        let secondaryTextContrast = contrastRatio(between: .secondary, and: style.backgroundColor)

        if primaryTextContrast < 4.5 {
            warnings.append("Tooltip background may have insufficient contrast with primary text (ratio: \(String(format: "%.2f", primaryTextContrast)), required: 4.5)")
        }

        if secondaryTextContrast < 4.5 {
            warnings.append("Tooltip background may have insufficient contrast with secondary text (ratio: \(String(format: "%.2f", secondaryTextContrast)), required: 4.5)")
        }

        return warnings
    }
}

// MARK: - TooltipStyle Accessibility Extension

public extension TooltipStyle {
    /// Validates this tooltip style for accessibility compliance
    /// - Returns: Array of accessibility warnings (empty if no issues)
    func validateAccessibility() -> [String] {
        AccessibilityHelpers.validateTooltipStyle(self)
    }

    /// Checks if this tooltip style meets WCAG AA standards for text contrast
    var meetsAccessibilityStandards: Bool {
        validateAccessibility().isEmpty
    }
}
