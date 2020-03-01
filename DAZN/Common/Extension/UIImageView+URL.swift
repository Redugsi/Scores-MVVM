//
//  UIImageView+URL.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(urlString: String) {
        
        if let cacheImage = app.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            app.imageCache.setObject(image, forKey: urlString as AnyObject)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()

    }
}
