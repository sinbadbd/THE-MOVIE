//
//  LaunchScreenVC.swift
//  TheMovies
//
//  Created by sinbad on 5/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class LaunchScreenVC : UIViewController {
    let bgView = UIView()
    let logo:UIImageView = UIImageView()
    let copyright = UILabel(title: "Copyright ©", size: 18, textAlign: .center)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchScreen()
    }
    func setupLaunchScreen(){
        view.addSubview(bgView)
        bgView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height:view.frame.height)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.setGradientBackground(colorTop: UIColor(red: 249/255, green: 159/255, blue: 8/255, alpha: 1), colorBottom: UIColor(red: 219/255, green: 48/255, blue: 105/255, alpha: 1))
        
        view.addSubview(logo)
        self.view.addConstraints([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 150),
            logo.heightAnchor.constraint(equalToConstant: 150),
            
            ]) 
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = #imageLiteral(resourceName: "logo")
        
        view.addSubview(copyright)
        copyright.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        
    }
}
