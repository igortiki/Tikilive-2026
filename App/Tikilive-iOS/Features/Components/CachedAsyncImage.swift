//
//  CachedAsyncImage.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/17/26
//

import SwiftUI
import TikiliveCore

struct CachedAsyncImage: View {
    let url: URL?
    let imageLoader: ImageLoader

    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Color.appChip
            }
        }
        .task(id: url) {
            image = nil

            guard let url else { return }

            do {
                image = try await imageLoader.loadImage(from: url)
            } catch {
                print("Image loading failed: \(error)")
            }
        }
    }
}
