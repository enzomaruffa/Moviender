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
    }
    
    class func instanceFromNib() -> MovieCardView {
        return UINib(nibName: "MovieCardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MovieCardView
    }
    
    @IBAction func imageClick(_ sender: Any) {
        self.removeFromSuperview()
        print("tapped")
    }
    
}
