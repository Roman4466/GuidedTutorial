//
//  ArrowView.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

struct ArrowView: View {
    let from: CGPoint
    let to: CGPoint
    let color: Color

    @State private var animationProgress: CGFloat = 0

    var body: some View {
        Canvas { context, size in
            let path = createCurvedPath(from: from, to: to)
            let trimmedPath = path.trimmedPath(from: 0, to: animationProgress)

            context.stroke(
                trimmedPath,
                with: .color(color),
                lineWidth: 3
            )

            // Draw arrowhead
            if animationProgress > 0.9 {
                drawArrowhead(context: &context, at: to, angle: calculateAngle(from: from, to: to))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: false)) {
                animationProgress = 1.0
            }
        }
    }

    private func createCurvedPath(from start: CGPoint, to end: CGPoint) -> Path {
        var path = Path()
        path.move(to: start)

        let controlPoint = CGPoint(
            x: (start.x + end.x) / 2,
            y: min(start.y, end.y) - 30
        )

        path.addQuadCurve(to: end, control: controlPoint)
        return path
    }

    private func calculateAngle(from start: CGPoint, to end: CGPoint) -> Double {
        let dx = end.x - start.x
        let dy = end.y - start.y
        return atan2(dy, dx)
    }

    private func drawArrowhead(context: inout GraphicsContext, at point: CGPoint, angle: Double) {
        var path = Path()

        let arrowSize: CGFloat = 10
        let angle1 = angle + .pi * 0.75
        let angle2 = angle - .pi * 0.75

        let point1 = CGPoint(
            x: point.x + arrowSize * cos(angle1),
            y: point.y + arrowSize * sin(angle1)
        )

        let point2 = CGPoint(
            x: point.x + arrowSize * cos(angle2),
            y: point.y + arrowSize * sin(angle2)
        )

        path.move(to: point1)
        path.addLine(to: point)
        path.addLine(to: point2)

        context.stroke(path, with: .color(color), lineWidth: 3)
    }
}
