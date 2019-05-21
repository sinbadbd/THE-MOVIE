//
//  TMLabel.swift
//  TheMovies
//
//  Created by sinbad on 5/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class TMLabel : UILabel {
    init(frame: CGRect, title: String = "Title", color: UIColor = .white, size: CGFloat = 16, textAlign:NSTextAlignment = .left) {
        super.init(frame: .zero)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.text = title
        self.textColor = color
        self.font = UIFont(name: "Roboto-Regular.ttf", size: size)
        self.textAlignment =  textAlign
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
