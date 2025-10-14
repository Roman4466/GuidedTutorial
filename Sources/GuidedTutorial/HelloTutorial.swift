//
//  HelloTutorial.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 12.09.2025.
//

import SwiftUI

public struct HelloTutorial: View {
    public init() {}
    
    public var body: some View {
        Text("🎯 Tutorial Framework Works!")
            .font(.title2)
            .foregroundColor(.blue)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.1))
            )
    }
}

public struct HelloTutorial_Previews: PreviewProvider {
    public static var previews: some View {
        HelloTutorial()
    }
}
