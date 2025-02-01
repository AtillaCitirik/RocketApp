//
//  ImageView+Ext.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 16.01.2025.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func loadImage(from url: String) {
        guard let url = URL(string: url) else {
            print("Geçersiz URL")
            return
        }

        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Resim indirme hatası: \(error)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Resim verisi okunamadı.")
                return
            }

            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
