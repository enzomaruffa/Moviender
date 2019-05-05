//
//  MovieTinderViewController.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class MovieTinderViewController: UIViewController {
    
    var movies : [Movie] = []
    var cards : [MovieCardView] = []
    var currentCard : MovieCardView?
    
    @IBOutlet weak var cardsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        movies = movies.filter { !AppData.sharedInstance.user.approvedRecomendations.contains($0) }
        movies = movies.filter { !AppData.sharedInstance.user.watched.contains($0) }
        self.createCards(movies: movies.reversed())
        // Do any additional setup after loading the view.
    }
    
    func createCards(movies: [Movie]) {
        for (current, movie) in movies.enumerated() {
            let offset = current - movies.count / 2
            createCard(offset : offset, movie: movie)
        }
        currentCard = cards.last
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
    
    @IBAction func refuseClick(_ sender: Any) {
        print("refuse")
        dismissCurrentCard(dismissPosition: CGPoint(x: cardsContainer.frame.minX - 200, y: cardsContainer.center.y))
    }
    
    @IBAction func acceptClick(_ sender: Any) {
        print("accept")
        let movie = (currentCard?.movie)!
        AppData.sharedInstance.user.approvedRecomendations.append(movie)
        AppData.sharedInstance.popularMovies.remove(movie : movie)
        AppData.sharedInstance.nowPlayingMovies.remove(movie : movie)
        AppData.sharedInstance.topRatedMovies.remove(movie : movie)
        dismissCurrentCard(dismissPosition: CGPoint(x: cardsContainer.frame.maxX + 200, y: cardsContainer.center.x))
    }
    
    @IBAction func seenClick(_ sender: Any) {
        print("seen")
        let movie = (currentCard?.movie)!
        AppData.sharedInstance.user.approvedRecomendations.append(movie)
        AppData.sharedInstance.popularMovies.remove(movie : movie)
        AppData.sharedInstance.nowPlayingMovies.remove(movie : movie)
        AppData.sharedInstance.topRatedMovies.remove(movie : movie)
        dismissCurrentCard(dismissPosition: CGPoint(x: cardsContainer.center.x, y: cardsContainer.frame.maxY + 200))
    }
    
    func dismissCurrentCard(dismissPosition : CGPoint) {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseInOut, animations: {
            print("running animation")
            self.currentCard?.alpha = 0
            self.currentCard?.center = dismissPosition
        }, completion: { finished in
            self.currentCard?.removeFromSuperview()
        })
        
        if cards.count > 0 {
            cards.removeLast()
            print("changing current card. count: ", cards.count)
            currentCard = cards.last
        } else {
            currentCard = nil
        }
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
