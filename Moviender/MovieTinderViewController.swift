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
    @IBOutlet weak var refuseButton: UIButton!
    @IBOutlet weak var seenButton: UIButton!
    @IBOutlet weak var acceptedButton: UIButton!
    
    @IBOutlet weak var cardsContainer: UIView!
    @IBOutlet weak var wowText: UILabel!
    
    let notificationFeedback = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        recreateView()
        UINavigationBar.appearance().tintColor = UIColor(red:0.57, green:0.14, blue:1.00, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    func recreateView() {
        cards.map {$0.removeFromSuperview()}
        cards = []
        currentCard = nil
        
        wowText.alpha = 0
        
        movies = movies.filter { !AppData.sharedInstance.user.approvedRecomendations.contains($0) }
        movies = movies.filter { !AppData.sharedInstance.user.watched.contains($0) }
        movies = movies.shuffled()
        self.createCards(movies: movies.reversed())
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
        card.frame = CGRect(x: cardsContainer.frame.minX + 20, y: cardsContainer.frame.minY - 80, width: cardsContainer.frame.width - 50, height: cardsContainer.frame.height - 80)
        print(card.frame)
        card.setupCard(movie: movie)
        
        let containerCenterX = (cardsContainer.frame.maxX - cardsContainer.frame.minX) / 2
        
        card.center.x = containerCenterX + CGFloat(offset * 2)
        card.center.y = card.center.y + 10 + CGFloat(offset) * 0.5
        
        cardsContainer.addSubview(card)
        cards.append(card)
    }
    
    @IBAction func refuseClick(_ sender: Any) {
        print("refuse")
        
        if let cardToDie = self.currentCard {
            UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
                print("running animation")
                
                cardToDie.alpha = 0
                cardToDie.transform = CGAffineTransform(rotationAngle: CGFloat(-1 * Double.pi/2))
                cardToDie.center = CGPoint(x: self.cardsContainer.frame.minX - 200, y: self.cardsContainer.center.y)
            }, completion: { finished in
                cardToDie.removeFromSuperview()
            })
            
            notificationFeedback.notificationOccurred(.error)
            self.dismissCurrentCard()
        }
    }
    
    @IBAction func acceptClick(_ sender: Any) {
        print("accept")
        
        if let cardToDie = self.currentCard {
            let movie = (cardToDie.movie)!
            AppData.sharedInstance.user.approvedRecomendations.append(movie)
            AppData.sharedInstance.popularMovies.remove(movie : movie)
            AppData.sharedInstance.nowPlayingMovies.remove(movie : movie)
            AppData.sharedInstance.topRatedMovies.remove(movie : movie)
            
            UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
                print("running animation")
                
                cardToDie.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/6))
                cardToDie.center = CGPoint(x: self.cardsContainer.frame.maxX + 200, y: self.cardsContainer.center.x)
                
                if let badgeValue = self.tabBarController?.tabBar.items?[0].badgeValue,
                    let value = Int(badgeValue) {
                    self.tabBarController?.tabBar.items?[0].badgeValue = String(value + 1)
                } else {
                    self.tabBarController?.tabBar.items?[0].badgeValue = "1"
                }
                
            }, completion: { finished in
                cardToDie.removeFromSuperview()
            })
            
            notificationFeedback.notificationOccurred(.warning)
            self.dismissCurrentCard()
        }
    }
    
    @IBAction func seenClick(_ sender: Any) {
        print("seen")
        
        
        if let cardToDie = self.currentCard {
            let movie = (cardToDie.movie)!
            AppData.sharedInstance.user.watched.append(movie)
            AppData.sharedInstance.popularMovies.remove(movie : movie)
            AppData.sharedInstance.nowPlayingMovies.remove(movie : movie)
            AppData.sharedInstance.topRatedMovies.remove(movie : movie)
            
            UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
                print("running animation")
                cardToDie.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                cardToDie.center = CGPoint(x: self.cardsContainer.center.x, y: self.cardsContainer.frame.maxY + 200)
                
                if let badgeValue = self.tabBarController?.tabBar.items?[2].badgeValue,
                    let value = Int(badgeValue) {
                    self.tabBarController?.tabBar.items?[2].badgeValue = String(value + 1)
                } else {
                    self.tabBarController?.tabBar.items?[2].badgeValue = "1"
                }
                
            }, completion: { finished in
                cardToDie.removeFromSuperview()
            })
            
            notificationFeedback.notificationOccurred(.success)
            self.dismissCurrentCard()
        }
    }
    
    func dismissCurrentCard() {
        if cards.count > 1 {
            cards.removeLast()
            print("changing current card. count: ", cards.count)
            currentCard = cards.last
        } else {
            currentCard = nil
            refuseButton.isEnabled = false
            seenButton.isEnabled = false
            acceptedButton.isEnabled = false
            
            UIView.animate(withDuration: 4, animations:{
                self.wowText.alpha = 1
            })
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
