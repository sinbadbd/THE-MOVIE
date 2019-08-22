
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
    
    var id : Int! {
        didSet {
            print("id", id)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
       
        let playerView = CGRect(x: 0, y: self.view.center.y, width: self.view.bounds.width, height: 240)
        let videoPlayer = YouTubePlayerView(frame: playerView)
        view.addSubview(videoPlayer)
        
        guard let id = id else {return }
        
        APIClient.getMovieVideoId(id: id) { (response, error) in
            if let response = response {
                self.video = response[0].results ?? []
                // print(response)
                DispatchQueue.main.async {
                    videoPlayer.loadVideoID(self.video[0].key ?? "")
                }
            }
        }
    }
}
