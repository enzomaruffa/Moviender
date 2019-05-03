//
//  WatchlistViewController.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController, MovieSelector {

    @IBOutlet weak var tableView: UITableView!
    
    var tableDelegate : MovieTableDelegate!
    var movies : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.largeTitleDisplayMode = .always
        
//        TMDB.setGenreList(params: ["" : ""])
        
        tableDelegate = MovieTableDelegate(movies: movies)
        tableDelegate.delegate = self

        tableView.delegate = tableDelegate
        tableView.dataSource = tableDelegate
        
        tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: "movieCell")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let movies = AppData.sharedInstance.user.approvedRecomendations
        tableDelegate.movieList = movies
        tableView.reloadData()
    }
    
    func didSelect(movie: Movie) {
        print("selected:", movie.title)
        performSegue(withIdentifier: "segueDetail", sender: movie)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            let movie = sender as! Movie
            if let vc = segue.destination as? MovieViewController {
                vc.movie = movie
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
