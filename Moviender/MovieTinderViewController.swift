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
        print(currentCard)
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
        dismissCurrentCard()
    }
    
    @IBAction func acceptClick(_ sender: Any) {
        print("accept")
        AppData.sharedInstance.user.approvedRecomendations.append((currentCard?.movie)!)
        dismissCurrentCard()
    }
    
    @IBAction func seenClick(_ sender: Any) {
        print("seen")
        AppData.sharedInstance.user.watched.append((currentCard?.movie)!)
        dismissCurrentCard()
    }
    
    func dismissCurrentCard() {
        print("dismissing!")
        print(currentCard)
        currentCard?.removeFromSuperview()
        cards.removeLast()
        currentCard = cards.last
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
