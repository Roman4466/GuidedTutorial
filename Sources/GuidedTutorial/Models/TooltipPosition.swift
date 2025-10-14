//
//  TooltipPosition.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI

public enum TooltipPosition: Equatable {
    case top(offset: CGFloat = 16)
    case bottom(offset: CGFloat = 16)
    case leading(offset: CGFloat = 16)
    case trailing(offset: CGFloat = 16)
    case topLeading(offset: CGFloat = 16)
    case topTrailing(offset: CGFloat = 16)
    case bottomLeading(offset: CGFloat = 16)
    case bottomTrailing(offset: CGFloat = 16)
    case center
    case automatic

    public static func == (lhs: TooltipPosition, rhs: TooltipPosition) -> Bool {
        switch (lhs, rhs) {
        case (.top(let o1), .top(let o2)),
             (.bottom(let o1), .bottom(let o2)),
             (.leading(let o1), .leading(let o2)),
             (.trailing(let o1), .trailing(let o2)),
             (.topLeading(let o1), .topLeading(let o2)),
             (.topTrailing(let o1), .topTrailing(let o2)),
             (.bottomLeading(let o1), .bottomLeading(let o2)),
             (.bottomTrailing(let o1), .bottomTrailing(let o2)):
            return o1 == o2
        case (.center, .center),
             (.automatic, .automatic):
            return true
        default:
            return false
        }
    }
}
