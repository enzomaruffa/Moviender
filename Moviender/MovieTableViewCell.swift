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
    @IBOutlet weak var tagsStackView: UIStackView!
    
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
        movieImage.setImageFromMovie(movie: movie, type: "poster")
        movieImage.layer.cornerRadius = 5
        
        //clears stack
        for subUIView in tagsStackView.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        
        for genre in movie.genres.prefix(3) {
            
            let button = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
            
            button.setTitle(genre.name, for: .normal)
            button.backgroundColor = genre.tagColor
            
            button.layer.cornerRadius = 5
            button.layer.borderColor = genre.tagColor.borderByBackground().cgColor
            button.layer.borderWidth = 1
            
            button.setTitleColor(genre.tagColor.borderByBackground(), for: UIControl.State.normal)
            
            tagsStackView.addArrangedSubview(button)
        }
        
    }
}
