
//
//  MovieVideioVC.swift
//  TheMovies
//
//  Created by sinbad on 8/21/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import YouTubePlayer

class MovieVideoVC : UIViewController {
    
    var playerV  : YouTubePlayerView!
    
    var video = [VideoResult]()
    override func viewDidLoad() {
        view.backgroundColor = .white
        //
        let playerView = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 240)
        let videoPlayer = YouTubePlayerView(frame: playerView)
        view.addSubview(videoPlayer)
        videoPlayer.loadVideoID("aqz-KE-bpKQ")
        
        
        APIClient.getMovieVideoId(id: 420818) { (response, error) in
             if let response = response {
                self.video = response[0].results ?? []
                print(response)
            }
        }
    }
}
