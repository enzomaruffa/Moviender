//
//  MovieCollection.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 04/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class MovieCollection {
    
    var movieList : [Movie] {
        didSet {
            movieList.sort { $0.title < $1.title }
        }
    }
    var apiPage : Int = 0
    var maxPage : Int = 2
    
    init(movieList: [Movie], apiPage: Int, maxPage : Int) {
        self.movieList = movieList
        self.apiPage = apiPage
        self.maxPage = maxPage
    }
    
    func remove(movie : Movie) {
        movieList.removeAll { $0.id == movie.id}
    }
    
}
