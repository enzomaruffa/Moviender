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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppData.getInstance()
//        TMDB.setGenreList(params: ["" : ""])
        
        let movies = Movie.randomList()
        print(movies)
        
        tableDelegate = MovieTableDelegate(movies: movies)
        tableDelegate.delegate = self

        tableView.delegate = tableDelegate
        tableView.dataSource = tableDelegate
        
        tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: "movieCell")

        // Do any additional setup after loading the view.
    }
    
    func didSelect(movie: Movie) {
        print("selected:", movie.title)
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
