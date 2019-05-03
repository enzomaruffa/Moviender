//
//  MovieTableViewCell.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(movie : Movie) {
        titleLabel.text = movie.title
        descriptionTextView.text = movie.description
        yearLabel.text = Calendar.current.component(.year, from: movie.releaseDate).description
        movieImage.setImageFromUrl(ImageURL: movie.TMDBPosterURLasString(width: 500))
    }
}
