//
//  APIClient.swift
//  TheMovies
//
//  Created by sinbad on 5/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

// Vedio link API
//http://api.themoviedb.org/3/movie/420817?api_key=de05a59a85ef1e7797de8d4a6d343d0e&append_to_response=videos

import Foundation
class APIClient {
    static let key = "?api_key=de05a59a85ef1e7797de8d4a6d343d0e"
    enum EndPoints {
        static let BASE_URL = "https://api.themoviedb.org/3/"
        static let POSTER_URL = "https://image.tmdb.org/t/p/w185_and_h278_bestv2"
        static let apiKeyParam = key 
        static let PAGE = "&page"
        
        case getNowPlayingMovie
        case getPopularMovies
        case getTopRatedMovies
        case getDiscoverMovies
        
        var stringValue : String {
            switch self {
                case .getNowPlayingMovie: return EndPoints.BASE_URL + "movie/now_playing" + EndPoints.apiKeyParam
                case .getPopularMovies : return EndPoints.BASE_URL + "movie/popular" + EndPoints.apiKeyParam
                case .getTopRatedMovies: return EndPoints.BASE_URL + "movie/top_rated" + EndPoints.apiKeyParam
                case .getDiscoverMovies: return EndPoints.BASE_URL + "discover/movie" + EndPoints.apiKeyParam
                
                
                
                
            }
        }
        var url : URL {
            return URL(string: stringValue)!
        }
    }
    // @GET REQUEST
    class func taskForGETRequest<ResponseType: Decodable>(url : URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?)-> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                DispatchQueue.main.sync {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    //@GET NOW PLAYING MOVIE LIST
    class func getNowPlayingMovieList(completion: @escaping([NowPlayingMovie]?, Error?)-> Void) {
        print(EndPoints.getNowPlayingMovie.url)
        taskForGETRequest(url: EndPoints.getNowPlayingMovie.url, response: NowPlayingMovie.self) { (response, error) in
            if let response = response {
                 completion([response], nil)
            } else {
                completion([], error)
                print(error.debugDescription)
            }
        }
    }
    
    //@GET POPULAR MOVIE
    class func getPopularMovieList(completion: @escaping([Movie]?, Error?)-> Void) {
        print(EndPoints.getPopularMovies.url)
        taskForGETRequest(url: EndPoints.getPopularMovies.url, response: Movie.self) { (response, error) in
            if let response = response {
               // print([response.results])
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    //@GET TOP RATED MOVIE
    class func getTopRatedMovieList(completion: @escaping([TopRated]?, Error?)-> Void) {
        print(EndPoints.getTopRatedMovies.url)
        taskForGETRequest(url: EndPoints.getTopRatedMovies.url, response: TopRated.self) { (response, error) in
            if let response = response {
                print("topMovi\([response.results])")
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    //@GET DISCOVER MOVIE
    class func getDiscoverMovieList(completion: @escaping([Discover]?, Error?)-> Void) {
        print(EndPoints.getTopRatedMovies.url)
        taskForGETRequest(url: EndPoints.getDiscoverMovies.url, response: Discover.self) { (response, error) in
            if let response = response {
                print("topMovi\([response.results])")
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    } 
}
