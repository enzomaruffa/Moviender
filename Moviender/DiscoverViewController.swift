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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppData.sharedInstance.popularMovies.movieList.count < 5 && AppData.sharedInstance.popularMovies.apiPage < AppData.sharedInstance.popularMovies.maxPage {
            
            AppData.sharedInstance.popularMovies.apiPage += 1
            let newPage = AppData.sharedInstance.popularMovies.apiPage
            
            TMDB.getPopularMovies(params: ["page" :  newPage.description]) { (result) in
                switch result {
                case .success(let movies):
                    print("puxei", movies.count, "movies!")
                    AppData.sharedInstance.popularMovies.movieList.append(contentsOf: movies)
                    self.popularMoviesBanner.setImageFromMovie(movie: AppData.sharedInstance.popularMovies.movieList.first!, type: "banner")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
        }
        
        if AppData.sharedInstance.topRatedMovies.movieList.count < 5 && AppData.sharedInstance.topRatedMovies.apiPage < AppData.sharedInstance.topRatedMovies.maxPage {
            
            AppData.sharedInstance.topRatedMovies.apiPage += 1
            let newPage = AppData.sharedInstance.topRatedMovies.apiPage
            
            TMDB.getTopRatedMovies(params: ["page" :  newPage.description]) { (result) in
                switch result {
                case .success(let movies):
                    print("puxei", movies.count, "movies!")
                    AppData.sharedInstance.topRatedMovies.movieList.append(contentsOf: movies)
                    self.topRatedBanner.setImageFromMovie(movie: AppData.sharedInstance.topRatedMovies.movieList.first!, type: "banner")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        if AppData.sharedInstance.nowPlayingMovies.movieList.count < 5 && AppData.sharedInstance.nowPlayingMovies.apiPage < AppData.sharedInstance.nowPlayingMovies.maxPage {
            
            AppData.sharedInstance.nowPlayingMovies.apiPage += 1
            let newPage = AppData.sharedInstance.nowPlayingMovies.apiPage
            
            TMDB.getNowPlayingMovies(params: ["page" :  newPage.description]) { (result) in
                switch result {
                case .success(let movies):
                    print("puxei", movies.count, "movies!")
                    AppData.sharedInstance.nowPlayingMovies.movieList.append(contentsOf: movies)
                    self.nowPlayingBanner.setImageFromMovie(movie: AppData.sharedInstance.nowPlayingMovies.movieList.first!, type: "banner")              case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
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
                    vc.movies = AppData.sharedInstance.topRatedMovies.movieList
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
