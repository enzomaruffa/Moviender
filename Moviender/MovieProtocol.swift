//
//  MovieProtocol.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 03/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import Foundation

protocol MovieSelector: class {
    func didSelect(movie: Movie)
}
