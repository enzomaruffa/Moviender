//
//  UIImageViewExtension.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 03/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageFromUrl(ImageURL :String) {
        print(ImageURL)
        URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    print("downloaded one image")
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
