//
//  TMLabel.swift
//  TheMovies
//
//  Created by sinbad on 5/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

extension UILabel {
   convenience init(frame: CGRect = .zero, title: String = "Title", color: UIColor = .white, size: CGFloat = 16, textAlign:NSTextAlignment = .left) {
    
        self.init(frame: .zero)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.text = title
        self.textColor = color
        self.font = UIFont(name: "Roboto-Regular.ttf", size: size)
        self.textAlignment =  textAlign
    }
    
    
}
