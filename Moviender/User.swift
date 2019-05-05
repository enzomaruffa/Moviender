//
//  User.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

class User {
    
    var name : String
    
    var watched : [Movie]
    var approvedRecomendations : [Movie]
    
    init(name: String, watched: [Movie], approvedRecomendations: [Movie]) {
        self.name = name
        self.watched = watched
        self.approvedRecomendations = approvedRecomendations
    }
    
}
