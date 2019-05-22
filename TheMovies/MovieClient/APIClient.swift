//
//  APIClient.swift
//  TheMovies
//
//  Created by sinbad on 5/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation
class APIClient {
    static let key = "?api_key=de05a59a85ef1e7797de8d4a6d343d0e"
    enum EndPoints {
        static let BASE_URL = "https://api.themoviedb.org/3/"
        static let POSTER_URL = "https://image.tmdb.org/t/p/w185_and_h278_bestv2"
        static let apiKeyParam = key
        
        case getMovieResult
        case getPopularMovies
        var stringValue : String {
            switch self {
            case .getMovieResult: return EndPoints.BASE_URL + "movie/now_playing" + EndPoints.apiKeyParam
            case .getPopularMovies : return EndPoints.BASE_URL + "movie/popular" + EndPoints.apiKeyParam
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
    class func getMovieResultList(completion: @escaping([MovieResult]?, Error?)-> Void) {
        print(EndPoints.getMovieResult.url)
        taskForGETRequest(url: EndPoints.getMovieResult.url, response: MovieResult.self) { (response, error) in
            if let response = response {
                 completion([response], nil)
            } else {
                completion([], error)
                print(error.debugDescription)
            }
        }
    }
    
    //@GET NOW PLAYING MOVIE LIST
    class func getPopularMovieList(completion: @escaping([Movie]?, Error?)-> Void) {
        print(EndPoints.getPopularMovies.url)
        taskForGETRequest(url: EndPoints.getPopularMovies.url, response: Movie.self) { (response, error) in
            if let response = response {
                print([response.results])
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
}
