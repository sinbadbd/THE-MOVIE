//
//  TVController.swift
//  TheMovies
//
//  Created by sinbad on 5/28/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class TVController: UIViewController {
    
    var topTvView : TopTVView {return self.view as! TopTVView}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "TV"
        
        self.view.addSubview(topTvView)
        topTvView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: topTvView.frame.width, height: 250))
    }
    override func loadView() {
        self.view = TopTVView(frame: UIScreen.main.bounds)
    }
}
