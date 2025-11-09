//
//  SpotlightOverlay.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct SpotlightOverlay: View {
    let targetFrame: CGRect
    let highlightShape: HighlightShape
    let blurStyle: BlurStyle

    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                context.fill(
                    Path(CGRect(origin: .zero, size: size)),
                    with: .color(blurStyle.dimColor.opacity(blurStyle.dimOpacity))
                )

                context.blendMode = .destinationOut
                let highlightPath = createHighlightPath(
                    in: targetFrame,
                    shape: highlightShape
                )
                context.fill(highlightPath, with: .color(.white))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .allowsHitTesting(false)
        }
    }

    private func createHighlightPath(in frame: CGRect, shape: HighlightShape) -> Path {
        switch shape {
        case .rectangle(let cornerRadius):
            return Path(roundedRect: frame, cornerRadius: cornerRadius)

        case .circle:
            let size = max(frame.width, frame.height)
            let center = CGPoint(x: frame.midX, y: frame.midY)
            return Path(ellipseIn: CGRect(
                x: center.x - size / 2,
                y: center.y - size / 2,
                width: size,
                height: size
            ))

        case .roundedRect(let cornerRadius):
            return Path(roundedRect: frame, cornerRadius: cornerRadius)

        case .custom:
            return Path(roundedRect: frame, cornerRadius: 8)
        }
    }
}
