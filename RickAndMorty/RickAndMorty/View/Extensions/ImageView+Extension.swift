//
//  ImageView+Extension.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit

extension UIImageView {
    
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            if let image = UIImage(data: cachedResponse.data) {
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    print("Failed to convert data to image")
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

