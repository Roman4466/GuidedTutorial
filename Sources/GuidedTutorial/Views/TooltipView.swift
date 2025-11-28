//
//  TooltipView.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct TooltipView: View {
    let step: TutorialStep
    let targetFrame: CGRect
    let screenSize: CGSize
    let onNext: () -> Void
    let onSkip: (() -> Void)?
    let tooltipStyle: TooltipStyle

    @State private var tooltipSize: CGSize = .zero
    @Environment(\.sizeCategory) var sizeCategory

    private var calculatedPosition: CGPoint {
        let defaultMaxWidth = tooltipStyle.maxWidth ?? min(screenSize.width - (tooltipStyle.padding * 2), maxTooltipWidth)
        let width = tooltipSize.width == 0 ? defaultMaxWidth : tooltipSize.width
        let height = tooltipSize.height == 0 ? 200 : tooltipSize.height

        return TooltipPositionCalculator.calculatePosition(
            tooltipPosition: step.tooltipPosition,
            targetFrame: targetFrame,
            screenSize: screenSize,
            tooltipSize: CGSize(width: width, height: height),
            tooltipStyle: tooltipStyle
        )
    }

    // Adjust max width based on accessibility text size
    private var maxTooltipWidth: CGFloat {
        switch sizeCategory {
        case .accessibilityMedium, .accessibilityLarge:
            return 400
        case .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            return 480
        default:
            return 320
        }
    }

    var body: some View {
        tooltipContent
            .accessibilityElement(children: .contain)
            .accessibilityLabel("\(step.title). \(step.description)")
            .accessibilityHint("Tutorial step. Use Next button to continue or Skip button to exit.")
            .padding(tooltipStyle.padding)
            .background(tooltipBackground)
            .frame(maxWidth: tooltipStyle.maxWidth ?? min(screenSize.width - (tooltipStyle.padding * 2), maxTooltipWidth))
            .overlay(
                GeometryReader { geo in
                    Color.clear.preference(key: SizePreferenceKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { size in
                tooltipSize = size
            }
            .position(calculatedPosition)
    }

    private var tooltipContent: some View {
        VStack(alignment: .leading, spacing: tooltipStyle.spacing) {
            Text(step.title)
                .font(tooltipStyle.titleFont)
                .foregroundColor(tooltipStyle.titleColor)
                .accessibilityAddTraits(.isHeader)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            Text(step.description)
                .font(tooltipStyle.descriptionFont)
                .foregroundColor(tooltipStyle.descriptionColor)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            if let customContent = step.customContent {
                customContent()
            }

            actionButtons
        }
    }

    private var actionButtons: some View {
        Group {
            if let customButtons = tooltipStyle.buttonStyle.customButtons, !customButtons.isEmpty {
                customButtonsView(customButtons)
            } else if shouldShowDefaultButtons {
                defaultButtonsView
            }
        }
    }

    private var shouldShowDefaultButtons: Bool {
        // Hide default buttons if a specific action is required (not tap or automatic)
        switch step.actionType {
        case .tap, .automatic:
            return true
        default:
            return false
        }
    }

    @ViewBuilder
    private func customButtonsView(_ buttons: [CustomButton]) -> some View {
        switch tooltipStyle.buttonStyle.buttonLayout {
        case .horizontal:
            HStack(spacing: tooltipStyle.buttonStyle.buttonSpacing) {
                ForEach(buttons) { button in
                    createButton(button)
                }
            }
        case .vertical:
            VStack(spacing: tooltipStyle.buttonStyle.buttonSpacing) {
                ForEach(buttons) { button in
                    createButton(button)
                }
            }
        case .custom:
            HStack(spacing: tooltipStyle.buttonStyle.buttonSpacing) {
                ForEach(buttons) { button in
                    createButton(button)
                }
            }
        }
    }

    private var defaultButtonsView: some View {
        Group {
            switch tooltipStyle.buttonStyle.buttonLayout {
            case .horizontal:
                HStack(spacing: tooltipStyle.buttonStyle.buttonSpacing) {
                    defaultButtons
                }
            case .vertical:
                VStack(spacing: tooltipStyle.buttonStyle.buttonSpacing) {
                    defaultButtons
                }
            case .custom:
                HStack(spacing: tooltipStyle.buttonStyle.buttonSpacing) {
                    defaultButtons
                }
            }
        }
    }

    @ViewBuilder
    private var defaultButtons: some View {
        if onSkip != nil {
            Button(tooltipStyle.buttonStyle.skipButtonText) {
                onSkip?()
            }
            .applyButtonStyle(tooltipStyle.buttonStyle.skipButtonStyle)
            .font(tooltipStyle.buttonFont)
            .applyButtonColor(tooltipStyle.buttonStyle.skipButtonColor)
            .accessibilityLabel("Skip tutorial")
            .accessibilityHint("Exits the current tutorial")
        }

        if tooltipStyle.buttonStyle.buttonLayout == .horizontal {
            Spacer()
        }

        Button(tooltipStyle.buttonStyle.nextButtonText) {
            onNext()
        }
        .font(tooltipStyle.buttonFont)
        .applyButtonStyle(tooltipStyle.buttonStyle.nextButtonStyle)
        .applyButtonColor(tooltipStyle.buttonStyle.nextButtonColor)
        .accessibilityLabel("Next step")
        .accessibilityHint("Continues to the next tutorial step")
    }

    private func createButton(_ button: CustomButton) -> some View {
        Button(button.text) {
            button.action()
        }
        .font(tooltipStyle.buttonFont)
        .applyButtonStyle(button.style)
        .applyButtonColor(button.color)
    }

    private var tooltipBackground: some View {
        RoundedRectangle(cornerRadius: tooltipStyle.cornerRadius)
            .fill(tooltipStyle.backgroundColor)
            .shadow(
                color: tooltipStyle.shadowColor.opacity(tooltipStyle.shadowOpacity),
                radius: tooltipStyle.shadowRadius,
                x: tooltipStyle.shadowX,
                y: tooltipStyle.shadowY
            )
    }
}

// Helper for measuring tooltip size
private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// Helper view modifiers for button customization
extension View {
    @ViewBuilder
    func applyButtonStyle(_ style: ButtonStyleType) -> some View {
        switch style {
        case .plain:
            self.buttonStyle(.plain)
        case .bordered:
            self.buttonStyle(.bordered)
        case .borderedProminent:
            self.buttonStyle(.borderedProminent)
        }
    }

    @ViewBuilder
    func applyButtonColor(_ color: Color?) -> some View {
        if let color = color {
            self.tint(color)
        } else {
            self
        }
    }
}
