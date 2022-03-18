//
//  APICaller.swift
//  Netflix
//
//  Created by Sai Balaji on 15/03/22.
//

import Foundation

struct Constants{
    static let API_KEY = "34b8226969614f1b92c4be3583ce7569"
    static let BASE_URL = "https://api.themoviedb.org"
    static let TRENDING_MOVIES_URL = "https://api.themoviedb.org/3/trending/movie/day?api_key=34b8226969614f1b92c4be3583ce7569"
    static let TRENDING_TV_URL = "https://api.themoviedb.org/3/trending/tv/day?api_key=34b8226969614f1b92c4be3583ce7569"
    static let UPCOMING_MOVIES = "https://api.themoviedb.org/3/movie/upcoming?api_key=34b8226969614f1b92c4be3583ce7569&language=en-US&page=1"
    static let POPULAR_MOVIES = "https://api.themoviedb.org/3/movie/popular?api_key=34b8226969614f1b92c4be3583ce7569&language=en-US&page=1"
    static let TOP_RATED = "https://api.themoviedb.org/3/movie/top_rated?api_key=34b8226969614f1b92c4be3583ce7569&language=en-US&page=1"
    static let MOVIE_SEARCH = "https://api.themoviedb.org/3/discover/movie?api_key=34b8226969614f1b92c4be3583ce7569&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    static let YOUTUBE_API_KEY = "AIzaSyD3LI2OmXq9IgwMOLB3eSqlZZLrlnhgcUQ"
}


class APICaller{
    static var sharedObj = APICaller()
    
    func getTrendingMovies(completion:@escaping([Title]?,Error?)->Void){
        
        guard let trendingURL = URL(string: Constants.TRENDING_MOVIES_URL) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: trendingURL) { data, resp, error in
            if let err = error{
                completion(nil,err)
                return
            }
            if let d = data
            {
                do{
                    let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: d)
                    //print(decodedData)
                    completion(decodedData.results,nil)
                }
                catch{
                    print(error.localizedDescription)
                }
            
            }
            
        }
        
        task.resume()
    
    }
    
    
    func getTrendingTV(completion:@escaping([Title]?,Error?)->Void){
        guard let tvUrl = URL(string: Constants.TRENDING_TV_URL)  else {return}
        let task = URLSession.shared.dataTask(with: tvUrl) { data, resp, error in
            if let err = error{
                completion(nil,err)
            }
            if let data = data {
                
                if let decodedData = try? JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                {
                    print(decodedData.results.count)
                    completion(decodedData.results,nil)
                }
             
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion:@escaping([Title]?,Error?)->Void){
        guard let upcomingUrl = URL(string:Constants.UPCOMING_MOVIES) else {return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: upcomingUrl) { data, resp, error in
            if let err = error{
                completion(nil,err)
            }
            if let data = data{
                if let decodedData = try? JSONDecoder().decode(TrendingTitleResponse.self, from: data){
                print(decodedData.results.count)
                completion(decodedData.results,nil)
                }
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion:@escaping([Title]?,Error?)->Void){
        guard let upcomingUrl = URL(string:Constants.POPULAR_MOVIES) else {return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: upcomingUrl) { data, resp, error in
            if let err = error{
                completion(nil,err)
            }
            if let data = data{
                if let decodedData = try? JSONDecoder().decode(TrendingTitleResponse.self, from: data){
                print(decodedData.results.count)
                completion(decodedData.results,nil)
                }
            }
        }
        task.resume()
    }
    
    func getTopRated(completion:@escaping([Title]?,Error?)->Void){
        guard let upcomingUrl = URL(string:Constants.TOP_RATED) else {return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: upcomingUrl) { data, resp, error in
            if let err = error{
                completion(nil,err)
            }
            if let data = data{
                if let decodedData = try? JSONDecoder().decode(TrendingTitleResponse.self, from: data){
                print(decodedData.results.count)
                completion(decodedData.results,nil)
                }
            }
        }
        task.resume()
    }
    
    func getDiscoverMovie(completion:@escaping([Title]?,Error?)->Void){
        let session = URLSession(configuration: .default)
        guard let moviesearchUrl = URL(string:Constants.MOVIE_SEARCH) else {return}
        
        let task = session.dataTask(with: moviesearchUrl) { data, resp, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil,error)
            }
            
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(TrendingTitleResponse.self, from: data){
                    completion(decodedData.results,nil)
                }
            }
        }
        task.resume()
    }
    
    func search(Query: String,completion:@escaping([Title]?,Error? )->Void){
        guard let Query = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        
        guard let searchURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=34b8226969614f1b92c4be3583ce7569&query=\(Query)") else {return }
        
        let session = URLSession(configuration: .default)
        
        
        let task = session.dataTask(with: searchURL) { data, resp, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil,error)
            }
            
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(TrendingTitleResponse.self, from: data){
                    completion(decodedData.results,nil)
                }
            }
        }
        task.resume()
        
        
        
    }
    
    func getMoiveFromYoutube(Query: String,completion:@escaping([VideoElement]?,Error?)->Void){
        guard let Query = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(Query)&key=\(Constants.YOUTUBE_API_KEY)") else{return}
        
        
        
        let session = URLSession(configuration: .default)
        
        
        let task = session.dataTask(with: url) { data, resp, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil,error)
            }
            
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(YoutubeSearchResponse.self, from: data){
                    print("DATA")
                    completion(decodedData.items,nil)
                    
                }
            }
        }
        task.resume()
                


    }
    
    
}
