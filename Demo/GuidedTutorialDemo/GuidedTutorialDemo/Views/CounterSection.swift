//
//  CounterSection.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct CounterSection: View {
    @ObservedObject var coordinator: TutorialCoordinator
    @Binding var counter: Int

    var body: some View {
        VStack(spacing: 15) {
            Text("Interactive Counter")
                .font(.headline)

            HStack(spacing: 20) {
                Button {
                    counter -= 1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                }
                .tutorialTarget("minusButton", coordinator: coordinator)

                Text("\(counter)")
                    .font(.system(size: 48, weight: .bold))
                    .frame(width: 100)
                    .tutorialTarget("counter", coordinator: coordinator)

                Button {
                    counter += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
                .tutorialTarget("plusButton", coordinator: coordinator)
            }
        }
        .padding()
        .background(Color(red: 0.88, green: 0.90, blue: 0.82))
        .cornerRadius(15)
        .id("counter")
    }
}
