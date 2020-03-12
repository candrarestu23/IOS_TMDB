//
//  UIImageView+Ext.swift
//  IndocyberTest
//
//  Created by Candra on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
  
  func loadImageUsingCache(withUrl urlString : String) {
    let stringWithPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = URL(string: stringWithPercent)
    self.image = nil
    
    // check cached image
    if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
      self.image = cachedImage
      return
    }
    
    // if not, download image from url
    guard let urlExist = url else { return }
    URLSession.shared.dataTask(with: urlExist, completionHandler: { (data, response, error) in
      if let error = error {
        #if DEBUG
        debugPrint("error load image", error)
        #endif
        return
      }

      DispatchQueue.main.async {
        if let image = UIImage(data: data!) {
          imageCache.setObject(image, forKey: urlString as NSString)
          self.image = image
        }
      }
      
    }).resume()
  }
  
  func loadImageWithURL(imageURL: String) {
    let stringWithPercent = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    if let url = URL(string: stringWithPercent) {
      let request = URLRequest(url: url)
      let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let imageData = data {
          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }
      }
      task.resume()
    }
  }
}
