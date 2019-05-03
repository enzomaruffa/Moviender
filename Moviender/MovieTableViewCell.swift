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
        movieImage.setImageFromUrl(ImageURL: movie.TMDBPosterURLasString(width: 500))
        
        print("movie genres:", movie.genres)
        print("movie genres:", movie.genreIds)
        
        //clears stack
        for subUIView in tagsStackView.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        
        for genre in movie.genres.prefix(3) {
            
            let tempButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
            tempButton.titleLabel?.font =  UIFont.systemFont(ofSize: 10)
            let desiredWidth = (tempButton.titleLabel)!.frame.width
            
            print(desiredWidth)
            
            let button = UIButton(frame: CGRect(x: 100, y: 100, width: desiredWidth, height: 50))
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 10)
            
            button.setTitle(genre.name, for: .normal)
            button.backgroundColor = genre.tagColor
            
            button.layer.cornerRadius = 5
            button.layer.borderColor = genre.tagColor.borderByBackground().cgColor
            button.setTitleColor(genre.tagColor.borderByBackground(), for: UIControl.State.normal)
            
            tagsStackView.addArrangedSubview(button)
        }
        
    }
}
