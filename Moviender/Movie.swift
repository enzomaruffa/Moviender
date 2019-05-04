//
//  Movie.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class Movie : Decodable {
    var id : Int
    var title : String
    lazy var genres : [Genre] = {
        return AppData.sharedInstance.genreList.filter { genreIds.contains($0.id) }
    }()
    var genreIds : [Int] = []
    var releaseDate : Date!
    var posterUrl : String!
    var backdropUrl : String!
    var voteAverage : Float!
    var description : String!
    var adult : Bool!
    var voteCount : Int!
    
    var posterImage : UIImage?
    var bannerImage : UIImage?
    
    init(title: String, id: Int, genres: [Genre], releaseDate: Date, posterUrl: String, backdropUrl: String, voteAverage: Float, description: String, adult: Bool, voteCount: Int) {
        self.title = title
        //self.genres = genres
        self.genreIds = []
        self.id = id
        self.releaseDate = releaseDate
        self.posterUrl = posterUrl
        self.backdropUrl = backdropUrl
        self.voteAverage = voteAverage
        self.description = description
        self.adult = adult
        self.voteCount = voteCount
    }
    
    enum CodingKeys: String, CodingKey {
        case title, id, adult
        case releaseDate = "release_date"
        case posterUrl = "poster_path"
        case backdropUrl = "backdrop_path"
        case voteAverage = "vote_average"
        case description = "overview"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        
        //        case tagColor
    }

    func TMDBPosterURLasString(width: Int) -> String {
        return "https://image.tmdb.org/t/p/w" + width.description + posterUrl
    }
    
    func TMDBBackdropURLasString(width: Int) -> String {
        return "https://image.tmdb.org/t/p/w" + width.description + backdropUrl
    }
}
