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
        static let apiKeyParam = key
        
        case getNowPlaying
        
        var stringValue : String {
            switch self {
            case .getNowPlaying: return EndPoints.BASE_URL + "movie/now_playing" + EndPoints.apiKeyParam
                
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
    
    class func getNowPlayingList(completion: @escaping([NowPlaying]?, Error?)-> Void) {
        print(EndPoints.getNowPlaying.url)
        taskForGETRequest(url: EndPoints.getNowPlaying.url, response: NowPlaying.self) { (response, error) in
            if let response = response {
//print([response.results])
  //              print([response.results.count])
              //  completion([response], nil)
              //  print("co\(completion([response], nil))")
                //print(response.results)
//                print("result: \( completion([response.results], nil))")
                 completion([response], nil)
            } else {
                //completion([], error)
                print(error.debugDescription)
            }
        }
    }
    
}
