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
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum EndPoints {
        static let BASE_URL = "https://api.themoviedb.org/3/"
        static let POSTER_URL = "https://image.tmdb.org/t/p/w185_and_h278_bestv2"
        static let BACKDROP_PATH = "https://image.tmdb.org/t/p/w500_and_h282_face/"
        static let PROFILE_URL = "https://image.tmdb.org/t/p/w138_and_h175_face/"
        static let PROFILE_FULL = "https://image.tmdb.org/t/p/w300_and_h450_bestv2/"
        static let apiKeyParam = key 
        static let PAGE = "&page"
        
        // MOVIE
        case getNowPlayingMovie
        case getPopularMovies
        case getTopRatedMovies
        case getDiscoverMovies
        case getMovieDetailsId(Int)
        case getMovieCreditsId(Int)
        case getArtistProfielId(Int)
        case getProfileImages(Int)
        case getArtistMovieCredits(Int)
        case searchMovieResult(String)
        case getFavoriteMovies
        
        
        // TV
        
        // Auth
        case getRequestToken
        case login
        case createSessionId
        var stringValue : String {
            switch self {
                case .getNowPlayingMovie: return EndPoints.BASE_URL + "movie/now_playing" + EndPoints.apiKeyParam
                case .getPopularMovies : return EndPoints.BASE_URL + "movie/popular" + EndPoints.apiKeyParam
                case .getTopRatedMovies: return EndPoints.BASE_URL + "movie/top_rated" + EndPoints.apiKeyParam
                case .getDiscoverMovies: return EndPoints.BASE_URL + "discover/movie" + EndPoints.apiKeyParam
                case .getMovieDetailsId(let id) : return EndPoints.BASE_URL + "movie/\(id)" + EndPoints.apiKeyParam
                case .getMovieCreditsId(let id) : return  EndPoints.BASE_URL + "movie/\(id)/credits" + EndPoints.apiKeyParam
                case .getArtistProfielId(let id) : return  EndPoints.BASE_URL + "person/\(id)" + EndPoints.apiKeyParam
                case .getProfileImages (let id): return  EndPoints.BASE_URL + "person/\(id)/images" + EndPoints.apiKeyParam
                case .getArtistMovieCredits(let id): return EndPoints.BASE_URL + "person/\(id)/movie_credits" + EndPoints.apiKeyParam
                case .searchMovieResult(let query): return EndPoints.BASE_URL + "search/movie" + EndPoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))"
                
                // Auth
                case .getRequestToken : return EndPoints.BASE_URL + "authentication/token/new" + EndPoints.apiKeyParam
                case .login : return EndPoints.BASE_URL + "authentication/token/validate_with_login" + EndPoints.apiKeyParam
                case .createSessionId : return EndPoints.BASE_URL + "authentication/session/new" + EndPoints.apiKeyParam
                case .getFavoriteMovies : return EndPoints.BASE_URL + "account/\(Auth.accountId)/favorite/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)" + "&sort_by=created_at.desc"
            }
        }
        var url : URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForPOSTRequest<RequestType:Encodable, ResponseType: Decodable> (url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping(ResponseType?, Error?)-> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil , error)
                }
                return
            }
            let decoder =  JSONDecoder()
            do {
                let requestObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(requestObject , nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil , error)
                }
            }
        }
        task.resume()
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
       // print(EndPoints.getNowPlayingMovie.url)
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
        //print(EndPoints.getPopularMovies.url)
        taskForGETRequest(url: EndPoints.getPopularMovies.url, response: Movie.self) { (response, error) in
            if let response = response {
              //  print(response)
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
        //print(EndPoints.getTopRatedMovies.url)
        taskForGETRequest(url: EndPoints.getTopRatedMovies.url, response: TopRated.self) { (response, error) in
            if let response = response {
              //  print("topMovi\([response.results])")
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
        //print(EndPoints.getTopRatedMovies.url)
        taskForGETRequest(url: EndPoints.getDiscoverMovies.url, response: Discover.self) { (response, error) in
            if let response = response {
              //  print("topMovi\([response.results])")
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    
    //@GET: ID MOVIES DETAILS
    class func getMovieId(id: Int, completion: @escaping(MovieDetails?, Error?)-> Void){
        taskForGETRequest(url: EndPoints.getMovieDetailsId(id).url, response: MovieDetails.self) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
                 print(error.debugDescription)
                 print(error?.localizedDescription ?? "")
            }
        }
    }
    
    //@GET: ID MOVIES credits
    class func getMovieCreditsId(id: Int, completion: @escaping([MovieCcredits]?, Error?)-> Void){
        taskForGETRequest(url: EndPoints.getMovieCreditsId(id).url, response: MovieCcredits.self) { (response, error) in
            if let response = response {
               // print("res\(response)")
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    //@GET: PERSION ID
    class func getArtistProfileId(id: Int, completion: @escaping(Artist?, Error?)-> Void){
        taskForGETRequest(url: EndPoints.getArtistProfielId(id).url, response: Artist.self) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    
    //@GET: ID MOVIES credits
    class func getPersonImageId(id: Int, completion: @escaping([Profile]?, Error?)-> Void){
        taskForGETRequest(url: EndPoints.getProfileImages(id).url, response: Profile.self) { (response, error) in
            if let response = response {
               // print("res\(response)")
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    //@GET: Artist MOVIE LIST CREDITS
    class func getPersonMovieCreditsId(id: Int, completion: @escaping([MovieCcredits]?, Error?)-> Void){
        taskForGETRequest(url: EndPoints.getArtistMovieCredits(id).url, response: MovieCcredits.self) { (response, error) in
            if let response = response {
              // print("res: \(response)")
                completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    
    // Search Result
    class func searchMovie(query: String, completion: @escaping([Movie]?, Error?)-> Void){
        taskForGETRequest(url: EndPoints.searchMovieResult(query).url, response: Movie.self) { (response, error) in
            if let response = response {
               // print("search:\(response)")
               completion([response], nil)
            } else {
                completion(nil, error)
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    class func getFavoriteMovie(completion: @escaping([Movie]?, Error?)->Void) {
        print(EndPoints.getFavoriteMovies.url)
//        taskForGETRequest(url: EndPoints.getFavoriteMovies.url, response: Favorit.self) { (response, error) in
//            if let response = response {
//                print([response.results])
//                //print(response.results as Any)
//                completion([response], nil)
//            } else {
//                completion(nil, error)
//                print(error.debugDescription)
//                print(error?.localizedDescription ?? "")
//            }
//        }
        
        taskForGETRequest(url: EndPoints.getFavoriteMovies.url, response: Movie.self) { (response, error) in
               if let response = response {
                  print(response)
                   completion([response], nil)
               } else {
                   completion([], error)
                   print(error.debugDescription)
                   print(error?.localizedDescription ?? "")
               }
           }
    }
    
    
    
    class func login(username: String, password: String, completion: @escaping(Bool, Error?)-> Void){
        
        let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken)
        taskForPOSTRequest(url: EndPoints.login.url, responseType: RequesTokenResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    
    class func createSessionId(completion: @escaping(Bool, Error?)-> Void) {
        let body = PostSession(requestToken: Auth.requestToken)
        taskForPOSTRequest(url: EndPoints.createSessionId.url, responseType: SessionResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.sessionId = response.sessionId
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func getRequestToken (completion: @escaping(Bool, Error?)-> Void) {
        let task = URLSession.shared.dataTask(with: EndPoints.getRequestToken.url) { (data, response, error) in
            guard let data = data else {
                completion(false, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(RequesTokenResponse.self, from: data)
                Auth.requestToken = responseObject.requestToken
                completion(true, nil)
            } catch {
                completion(true, nil)
            }
            
        }
        task.resume()
    }
    
}
