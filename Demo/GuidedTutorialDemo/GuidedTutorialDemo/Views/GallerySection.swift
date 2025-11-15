
//
//  GallerySection.swift
//  GuidedTutorialDemo
//
//  Created by Roman Malynovsky on 02.11.2025.
//

import SwiftUI
import GuidedTutorial

struct GallerySection: View {
    @ObservedObject var coordinator: TutorialCoordinator
    @Binding var selectedImage: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Gallery")
                .font(.headline)
                .tutorialTarget("galleryTitle", coordinator: coordinator)

            ScrollViewReader { galleryScrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<5) { index in
                            Image(systemName: ["photo", "camera", "video", "music.note", "book"][index])
                                .font(.system(size: 40))
                                .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.4))
                                .frame(width: 100, height: 100)
                                .background(Color(red: 0.85, green: 0.80, blue: 0.72))
                                .cornerRadius(12)
                                .onTapGesture {
                                    selectedImage = index
                                }
                                .tutorialTarget("galleryItem\(index)", coordinator: coordinator)
                                .id("galleryItem\(index)")
                        }
                    }
                }
                .onChange(of: coordinator.currentStep?.targetKey) { targetKey in
                    if let targetKey = targetKey, targetKey.hasPrefix("galleryItem") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            galleryScrollProxy.scrollTo(targetKey, anchor: .center)
                        }
                    }
                }
            }
            .tutorialTarget("imageGallery", coordinator: coordinator)
        }
        .id("imageGallery")
    }
}
