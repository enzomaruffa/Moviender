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
    static var instance : AppData = AppData()
    
    private init() {
        self.user = User(name: "Enzo", watched: [], recomendations: [], approvedRecomendations: [])
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
    
    static func getInstance() -> AppData {
        return instance
    }
    
}
