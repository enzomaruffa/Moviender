//
//  MovieCardView.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 03/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class MovieCardView: UIView {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(movie : Movie) {
        titleLabel.text = movie.title
        movieImage.setImageFromUrl(ImageURL: movie.posterUrl)
    }

}
