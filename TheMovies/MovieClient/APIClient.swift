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
}
