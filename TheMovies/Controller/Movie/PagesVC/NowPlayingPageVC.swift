//
//  NowPlayingPageVC.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class NowPlayingPageVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
