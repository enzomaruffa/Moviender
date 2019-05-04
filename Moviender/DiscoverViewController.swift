//
//  DiscoverViewController.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    var cards : [MovieCardView] = []
    
    @IBOutlet weak var cardsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDB.getPopularMovies(params: ["" : ""]) { (result) in
            switch result {
            case .success(let movies):
                print("puxei", movies.count, "movies!")
                AppData.sharedInstance.user.approvedRecomendations = movies
                DispatchQueue.main.async {
                   self.createCards(movies: movies.reversed())
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func createCards(movies: [Movie]) {
        for movie in movies {
            createCard(movie: movie)
        }
    }
    
    func createCard(movie: Movie) {
        let card = MovieCardView.instanceFromNib()
        card.setupCard(movie: movie)
        cardsContainer.addSubview(card)
        cards.append(card)
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
