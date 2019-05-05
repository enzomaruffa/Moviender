//
//  Genre.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class Genre : Decodable {
    
    var name : String
    var id : Int
    var tagColor : UIColor {
        switch name {
            case "Action":
                return UIColor(red: 0.7, green: 0, blue: 0, alpha: 1)
            case "Adventure":
                return UIColor(red: 1, green: 0.7, blue: 0, alpha: 1)
            case "Comedy":
                return UIColor(red: 0.7, green: 0.7, blue: 0, alpha: 1)
            case "Drama":
                return UIColor(red: 0.6, green: 0, blue: 0.6, alpha: 1)
            case "Fantasy":
                return UIColor(red: 0, green: 0, blue: 0.8, alpha: 1)
            case "Horror":
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            case "Animation":
                return UIColor(red: 0, green: 0.7, blue: 0.8, alpha: 1)
            case "Science Fiction":
                return UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
            default:
                return .white
        }
    }
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case name, id

//        case tagColor
    }
//
//    static func createListFromJson (json:[String:AnyObject]) -> [Genre] {
//        var genreList : [Genre] = []
//
//        print("json:", json)
//        print("json[genres]:", json["genres"])
//
//        return genreList
//    }
    
}
