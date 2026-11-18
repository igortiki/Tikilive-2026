//
//  ImageCache.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/17/26
//

import Foundation
import UIKit

final class ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for url: NSURL) -> UIImage? {
        cache.object(forKey: url)
    }
    
    func setImage(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }

    // Not used yet; reserved for clearing the cache later
    func clear() {
        cache.removeAllObjects()
    }
}
