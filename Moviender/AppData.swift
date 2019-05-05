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
    
    var popularMovies : MovieCollection = MovieCollection(movieList: [], apiPage: 0)
    var topRatedMovies : MovieCollection = MovieCollection(movieList: [], apiPage: 0)
    var nowPlayingMovies : MovieCollection = MovieCollection(movieList: [], apiPage: 0)
    
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
    
}
