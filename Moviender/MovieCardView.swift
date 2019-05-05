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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tagsStackView: UIStackView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCard(movie : Movie) {
        titleLabel.text = movie.title
        movieImage.setImageFromMovie(movie: movie, type: "poster")
        
        dateLabel.text = Calendar.current.component(.year, from: movie.releaseDate).description
        descriptionTextView.text = movie.description
        
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
            button.layer.borderColor = genre.tagColor.cgColor
            button.layer.borderWidth = 1
            
            button.setTitleColor(genre.tagColor.borderByBackground(), for: UIControl.State.normal)
            
            tagsStackView.addArrangedSubview(button)
        }
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
    }
    
    class func instanceFromNib() -> MovieCardView {
        return UINib(nibName: "MovieCardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MovieCardView
    }
    
}
