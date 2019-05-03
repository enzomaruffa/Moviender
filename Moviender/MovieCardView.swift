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
    
    func fromNib() {   // 2
        Bundle.main.loadNibNamed("MovieCardView", owner: self, options: nil)
        addSubview(contentView)     // 4
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    func setupCard(movie : Movie) {
        titleLabel.text = movie.title
        movieImage.setImageFromUrl(ImageURL: movie.TMDBPosterURLasString(width: 500))
    }

}
