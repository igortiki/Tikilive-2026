//
//  CachedAsyncImage.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/17/26
//

import SwiftUI
import TikiliveUI

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
            } catch is CancellationError, URLError.cancelled {
                // cancelled when the row leaves the screen, not a real error
            } catch {
                print("Image loading failed: \(error)")
            }
        }
    }
}
