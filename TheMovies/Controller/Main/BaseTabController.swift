//
//  BaseTabController.swift
//  TheMovies
//
//  Created by sinbad on 5/21/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class BaseTabController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        
        
        viewControllers = [
            createNavController(viewController: MovieController(), title: "Movie", imageView: "movie"),
            createNavController(viewController: TVController(), title: "Movie", imageView: "television")
        ]
    } 
}

func createNavController (viewController : UIViewController, title: String, imageView: String) -> UIViewController {
    
   // viewController.view.backgroundColor = .white
//    viewController.navigationItem.title = title
    
   // let navController = UINavigationController(rootViewController: viewController)
     viewController.tabBarItem.title = title
   viewController.tabBarItem.image = UIImage(named: imageView)
    return viewController
}
