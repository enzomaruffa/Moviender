//
//  Movie.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class Movie : Decodable {
    var id : Int
    var title : String
    var genres : [Genre] = []
    var genreIds : [Int] = [] {
        didSet {
            self.genres = AppData.getInstance().genreList.filter { genreIds.contains($0.id) }
        }
    }
    var releaseDate : Date
    var imageURL : String
    var voteAverage : Float
    var description : String
    
    init(title: String, id: Int, genres: [Genre], releaseDate: Date, imageURL: String, voteAverage: Float, description: String) {
        self.title = title
        self.genres = genres
        self.id = id
        self.releaseDate = releaseDate
        self.imageURL = imageURL
        self.voteAverage = voteAverage
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case title, id
        case releaseDate = "release_date"
        case imageURL = "poster_path"
        case voteAverage = "vote_average"
        case description = "overview"
        case genreIds = "genre_ids"
        
        //        case tagColor
    }
}
