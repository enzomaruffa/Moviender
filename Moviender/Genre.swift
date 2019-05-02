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
    var tagColor : UIColor!
//    var tagColor : UIColor {
//        return .white
//    }
    
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
