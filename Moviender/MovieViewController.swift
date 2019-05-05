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
    
    var movie : Movie!
    
    override func viewWillAppear(_ animated: Bool) {
        backdropImage.setImageFromMovie(movie: movie, type: "banner")
        titleLabel.text = movie.title
        descriptionTextView.text = movie.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "DD-MM-YYYY"
        dateLabel.text = formatter.string(from: movie.releaseDate)
        voteAverageLabel.text = movie.voteAverage.description
        voteCountLabel.text = "(" + movie.voteCount.description + " votes)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem?.tintColor = .white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToRecommendations(_ sender: Any) {
        performSegue(withIdentifier: "goToRecommendations", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecommendations" {
            if let vc = segue.destination as? MovieTinderViewController {
                
                vc.movies = []
                TMDB.getMovieRecommendations(movie: movie, params: ["page" :  "1"]) { (result) in
                    switch result {
                    case .success(let movies):
                        print("puxei", movies.count, "movies!")
                        vc.movies = movies
                        DispatchQueue.main.async {
                            vc.recreateView()
                        }
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        
            }
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
