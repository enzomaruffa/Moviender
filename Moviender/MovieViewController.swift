//
//  MovieViewController.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie : Movie!
    
    override func viewWillAppear(_ animated: Bool) {
        backdropImage.setImageFromUrl(ImageURL: movie.TMDBBackdropURLasString(width: 415))
        titleLabel.text = movie.title
        descriptionTextView.text = movie.description
        dateLabel.text = movie.releaseDate.description
        voteAverageLabel.text = movie.voteAverage.description
        voteCountLabel.text = movie.voteCount.description
        posterImage.setImageFromUrl(ImageURL: movie.TMDBPosterURLasString(width: 170))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
