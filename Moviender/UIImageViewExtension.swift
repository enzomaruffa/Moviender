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
    
    func setImageFromMovie(movie : Movie, type : String) {
        print(movie, type)
        
        if type == "banner" && movie.bannerImage != nil {
            self.image = movie.bannerImage
            print("using cached")
            return
        } else if type == "poster" && movie.posterImage != nil  {
            self.image = movie.posterImage
            print("using cached")
            return
        }
        
        print("downloading")
        
        var url = ""
        switch type {
        case "poster":
            url = movie.TMDBPosterURLasString(width: 500)
            break
        case "banner":
            url = movie.TMDBBackdropURLasString(width: 1280)
            break
        default:
            url = ""
        }
        
        URLSession.shared.dataTask( with: NSURL(string:url)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    print("downloaded one image")
                    self.image = UIImage(data: data)

                    switch type {
                    case "poster":
                        movie.posterImage = self.image
                        break
                    case "banner":
                        movie.bannerImage = self.image
                        break
                    default:
                        break
                    }
                }
            }
        }).resume()
    }
}

extension UIImage {
    
    static func createImageFromURL(imageURL: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        URLSession.shared.dataTask( with: NSURL(string:imageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    let image = UIImage(data: data)!
                    completion(.success(image))
                } 
            }
        }).resume()
    }
    
}

