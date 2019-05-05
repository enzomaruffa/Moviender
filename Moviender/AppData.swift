//
//  AppData.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class AppData {
    
    var user : User
    var genreList : [Genre]
    
    var popularMovies : MovieCollection = MovieCollection(movieList: [], apiPage: 0, maxPage: 10)
    var topRatedMovies : MovieCollection = MovieCollection(movieList: [], apiPage: 0, maxPage: 10)
    var nowPlayingMovies : MovieCollection = MovieCollection(movieList: [], apiPage: 0, maxPage: 10)
    
    static var sharedInstance : AppData = AppData()
    
    private init() {
        self.user = User(name: "Enzo", watched: [], approvedRecomendations: [])
        self.genreList = []
        
        TMDB.setGenreList(params: ["" : ""]) { (result) in
            switch result {
            case .success(let genres):
                self.genreList = genres
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeFromCollections(movie : Movie) {
        popularMovies.remove(movie: movie)
        topRatedMovies.remove(movie: movie)
        nowPlayingMovies.remove(movie: movie)
    }
    
}
