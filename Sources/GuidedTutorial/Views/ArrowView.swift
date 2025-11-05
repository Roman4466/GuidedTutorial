import SwiftUI

extension CGPath {
    func forEach(body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
    
    func getPathElementsPoints() -> [[CGPoint]] {
        var arrayPoints: [[CGPoint]] = []
        self.forEach { element in
            switch element.type {
            case .moveToPoint:
                arrayPoints.append([element.points[0]])
            case .addLineToPoint:
                arrayPoints.append([element.points[0]])
            case .addQuadCurveToPoint:
                arrayPoints.append([element.points[0], element.points[1]])
            case .addCurveToPoint:
                arrayPoints.append([element.points[0], element.points[1], element.points[2]])
            case .closeSubpath:
                break
            @unknown default:
                break
            }
        }
        return arrayPoints
    }
}

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
            y: min(start.y, end.y)
        )

        path.addQuadCurve(to: end, control: controlPoint)
        
        // Calculate tangent at end point (t=1) for quadratic Bezier
        // Quadratic Bezier: B(t) = (1-t)²*P0 + 2(1-t)t*P1 + t²*P2
        // Derivative: B'(t) = 2(1-t)(P1-P0) + 2t(P2-P1)
        // At t=1: B'(1) = 2(P2-P1)
        
        // But we need tangent slightly before the end to get proper direction
        let t: CGFloat = 0.99
        let oneMinusT = 1 - t
        
        // Derivative components
        let dx = 2 * oneMinusT * (controlPoint.x - start.x) + 2 * t * (end.x - controlPoint.x)
        let dy = 2 * oneMinusT * (controlPoint.y - start.y) + 2 * t * (end.y - controlPoint.y)
        
        let tangentAngle = atan2(dy, dx)
        
        let lineLength: CGFloat = 15
        let arrowAngle: CGFloat = 30 * .pi / 180
        
        // Left line
        let leftAngle = tangentAngle + .pi - arrowAngle
        let leftPoint = CGPoint(
            x: end.x + lineLength * cos(leftAngle),
            y: end.y + lineLength * sin(leftAngle)
        )
        path.addLine(to: leftPoint)
        path.move(to: end)
        
        // Right line
        let rightAngle = tangentAngle + .pi + arrowAngle
        let rightPoint = CGPoint(
            x: end.x + lineLength * cos(rightAngle),
            y: end.y + lineLength * sin(rightAngle)
        )
        path.addLine(to: rightPoint)
        
        return path
    }
}
