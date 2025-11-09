//
//  BlurStyle.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI

public struct BlurStyle: Sendable {
    public let dimColor: Color
    public let dimOpacity: Double

    public init(
        dimColor: Color = .black,
        dimOpacity: Double = 0.7
    ) {
        self.dimColor = dimColor
        self.dimOpacity = dimOpacity
    }

    public static let `default` = BlurStyle()
}
