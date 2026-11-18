//
//  ImageLoader.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/17/26
//

import UIKit

@MainActor
public final class ImageLoader {
    private let cache: ImageCache
    
    init(cache: ImageCache) {
        self.cache = cache
    }
    
    public func loadImage(from url: URL) async throws -> UIImage {
        
        // 1. Check cache
        if let image = cache.image(for: url as NSURL) {
            return image
        }
        
        // 2. Download image
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw ImageLoaderError.invalidImage
        }
        
        // 3. Decode off the main thread so rendering doesn't have to
        let preparedImage = await image.byPreparingForDisplay() ?? image

        // 4. Save the decoded image to cache
        cache.setImage(preparedImage, for: url as NSURL)

        return preparedImage
    }
    
    // Not used yet; reserved for clearing the cache later
    public func clearCache() {
        cache.clear()
    }
}
