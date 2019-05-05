//
//  TMDB.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

// https://developers.themoviedb.org/3/movies/get-top-rated-movies

import Foundation

class TMDB {
    
    static let API_KEY : String = "ddcd29e74a71b4f54c6e2faffd34148d"
    static let BASIS_URL : String = "https://api.themoviedb.org/3"
    
    static func setGenreList(params: [String:String], completion: @escaping (Result<[Genre], Error>) -> ()) {
        var urlComponents = URLComponents(string: BASIS_URL + "/genre/movie/list")!
        
        // cria lista de parametros
        var items = [URLQueryItem]()
        
        // cria parametro da API_key
        items.append(URLQueryItem(name: "api_key", value: API_KEY))
        
        // adiciona outros parametros
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        // filtra os parametros sem nome
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComponents.queryItems = items
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    let dataGenres = try JSONSerialization.data(withJSONObject: json["genres"]!, options: [])
                    let genres = try JSONDecoder().decode([Genre].self, from: dataGenres)
                    
                    print(genres)
                    genres.forEach({ print($0.id, " ", $0.name) })
                    
                    completion(.success(genres))
                } catch {
                    completion(.failure(error))
                    print("[ERROR] Error getting genres")
                }
            }
            else if error != nil
            {
                completion(.failure(error!))
                print("[ERROR] Error getting genres")
            }
        }).resume()
    }
    
    static func getPopularMovies(params: [String:String], completion: @escaping (Result<[Movie], Error>) -> ()) {
        var urlComponents = URLComponents(string: BASIS_URL + "/movie/popular")!
        
        // cria lista de parametros
        var items = [URLQueryItem]()
        
        // cria parametro da API_key
        items.append(URLQueryItem(name: "api_key", value: API_KEY))
        
        // adiciona outros parametros
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        // filtra os parametros sem nome
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComponents.queryItems = items
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-DD"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let dataMovies = try JSONSerialization.data(withJSONObject: json["results"]!, options: [])
                    let movies = try decoder.decode([Movie].self, from: dataMovies)
                    
                    print(movies)
                    movies.forEach({ print($0.id, " ", $0.title) })
                    
                    if let maxPage = json["total_pages"] as! Int? {
                        AppData.sharedInstance.popularMovies.maxPage = maxPage
                    }
                    
                    completion(.success(movies))
                } catch {
                    completion(.failure(error))
                    print("[ERROR] Error getting movies. catch")
                }
            }
            else if error != nil
            {
                completion(.failure(error!))
                print("[ERROR] Error getting movies. not nil")
            }
        }).resume()
    }
    
    static func getTopRatedMovies(params: [String:String], completion: @escaping (Result<[Movie], Error>) -> ()) {
        var urlComponents = URLComponents(string: BASIS_URL + "/movie/top_rated")!
        
        // cria lista de parametros
        var items = [URLQueryItem]()
        
        // cria parametro da API_key
        items.append(URLQueryItem(name: "api_key", value: API_KEY))
        
        // adiciona outros parametros
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        // filtra os parametros sem nome
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComponents.queryItems = items
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-DD"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let dataMovies = try JSONSerialization.data(withJSONObject: json["results"]!, options: [])
                    let movies = try decoder.decode([Movie].self, from: dataMovies)
                    
                    print(movies)
                    movies.forEach({ print($0.id, " ", $0.title) })
                    
                    if let maxPage = json["total_pages"] as! Int? {
                        AppData.sharedInstance.topRatedMovies.maxPage = maxPage
                    }
                    
                    completion(.success(movies))
                } catch {
                    completion(.failure(error))
                    print("[ERROR] Error getting movies. catch")
                }
            }
            else if error != nil
            {
                completion(.failure(error!))
                print("[ERROR] Error getting movies. not nil")
            }
        }).resume()
    }
    
    static func getNowPlayingMovies(params: [String:String], completion: @escaping (Result<[Movie], Error>) -> ()) {
        var urlComponents = URLComponents(string: BASIS_URL + "/movie/now_playing")!
        
        // cria lista de parametros
        var items = [URLQueryItem]()
        
        // cria parametro da API_key
        items.append(URLQueryItem(name: "api_key", value: API_KEY))
        
        // adiciona outros parametros
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        // filtra os parametros sem nome
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComponents.queryItems = items
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-DD"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let dataMovies = try JSONSerialization.data(withJSONObject: json["results"], options: [])
                    let movies = try decoder.decode([Movie].self, from: dataMovies)
                    
                    if let maxPage = json["total_pages"] as! Int? {
                        AppData.sharedInstance.nowPlayingMovies.maxPage = maxPage
                    }
                    
                    print(movies)
                    movies.forEach({ print($0.id, " ", $0.title) })
                    
                    completion(.success(movies))
                } catch {
                    completion(.failure(error))
                    print("[ERROR] Error getting movies. catch")
                }
            }
            else if error != nil
            {
                completion(.failure(error!))
                print("[ERROR] Error getting movies. not nil")
            }
        }).resume()
    }
}
