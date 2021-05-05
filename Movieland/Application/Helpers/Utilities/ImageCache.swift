//
//  ImageCache.swift
//  Movieland
//
//  Created by Dante Solorio on 05/05/21.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    subscript(key: String) -> UIImage? {
        get {
            cache.object(forKey: key as NSString)
        }
        set (image) {
            if let image = image {
                cache.setObject(image, forKey: key as NSString)
            } else {
                cache.removeObject(forKey: key as NSString)
            }
        }
    }
}
