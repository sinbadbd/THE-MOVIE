//
//  PopularMoviesCell.swift
//  TheMovies
//
//  Created by sinbad on 5/22/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit 
import SDWebImage

class PopularMoviesCell : UICollectionViewCell   {
    
    var popularVC = PopularVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(popularVC.view)
        
        popularVC.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0)) 
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
