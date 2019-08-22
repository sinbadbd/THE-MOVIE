
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
        
        let mainView = UIView()
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        mainView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
 
        let playerView = CGRect(x: 0, y: self.view.center.y, width: self.view.bounds.width, height: 240)
        let videoPlayer = YouTubePlayerView(frame: playerView)
        mainView.addSubview(videoPlayer)
        
        //let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector("targetViewDidTapped"))
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        mainView.addGestureRecognizer(tap)
      //  gesture.numberOfTapsRequired = 1
        mainView.isUserInteractionEnabled = true
       // mainView.addGestureRecognizer(gesture)
        
        
        
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
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        self.dismiss(animated: true, completion: nil)
    }
}
