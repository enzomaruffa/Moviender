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
        for (current, movie) in movies.enumerated() {
            let offset = current - movies.count / 2
            createCard(offset : offset, movie: movie)
        }
    }
    
    func createCard(offset : Int, movie: Movie) {
        let card = MovieCardView.instanceFromNib()
        card.setupCard(movie: movie)
        
        let containerCenterX = (cardsContainer.frame.maxX - cardsContainer.frame.minX) / 2
        
        card.center.x = containerCenterX + CGFloat(offset * 2)
        card.center.y = card.center.y + 10 + CGFloat(offset) * 0.5
            
        
        
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
