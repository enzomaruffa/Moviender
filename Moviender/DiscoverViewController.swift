//
//  MovieTinderViewController.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var popularMoviesBanner: UIImageView!
    @IBOutlet weak var topRatedBanner: UIImageView!
    @IBOutlet weak var nowPlayingBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppData.sharedInstance.popularMovies.movieList.isEmpty {
            
            TMDB.getPopularMovies(params: ["page" : "1"]) { (result) in
                switch result {
                case .success(let movies):
                    print("puxei", movies.count, "movies!")
                    AppData.sharedInstance.popularMovies.movieList = movies
                    AppData.sharedInstance.popularMovies.apiPage = 1
                    DispatchQueue.main.async {
                        self.popularMoviesBanner.setImageFromMovie(movie: (movies.first)!, type: "banner")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            TMDB.getTopRatedMovies(params: ["page" : "1"]) { (result) in
                switch result {
                case .success(let movies):
                    print("puxei", movies.count, "movies!")
                    AppData.sharedInstance.topRatedMovies.movieList = movies
                    AppData.sharedInstance.topRatedMovies.apiPage = 1
                    DispatchQueue.main.async {
                        self.topRatedBanner.setImageFromMovie(movie: (movies.first)!, type: "banner")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            TMDB.getNowPlayingMovies(params: ["page":"1"]) { (result) in
                switch result {
                case .success(let movies):
                    print("puxei", movies.count, "movies!")
                    AppData.sharedInstance.nowPlayingMovies.movieList = movies
                    AppData.sharedInstance.nowPlayingMovies.apiPage = 1
                    DispatchQueue.main.async {
                        self.nowPlayingBanner.setImageFromMovie(movie: (movies.first)!, type: "banner")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func popularImageClick(_ sender: Any) {
        print("tapped popular")
        performSegue(withIdentifier: "goToTinderView", sender: "popular")
    }
    
    @IBAction func topRatedImageClick(_ sender: Any) {
        print("tapped topRated")
        performSegue(withIdentifier: "goToTinderView", sender: "top rated")
    }
    
    @IBAction func recentlyAddedImageClick(_ sender:
        Any) {
        print("tapped recentlyAdded")
        performSegue(withIdentifier: "goToTinderView", sender: "now playing")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTinderView" {
            if let vc = segue.destination as? MovieTinderViewController {
                let type = sender as! String
                if type == "popular" {
                    vc.movies = AppData.sharedInstance.popularMovies.movieList
                    vc.title = "Popular"
                } else if type == "top rated" {
                    vc.movies = AppData.sharedInstance.topRatedMovies.movieList
                    vc.title = "Top Rated"
                } else if type == "now playing" {
                    vc.movies = AppData.sharedInstance.nowPlayingMovies.movieList
                    vc.title = "Now Playing"
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
