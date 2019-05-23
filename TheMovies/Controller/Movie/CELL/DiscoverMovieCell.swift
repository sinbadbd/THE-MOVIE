//
//  DiscoverMovieCell.swift
//  TheMovies
//
//  Created by sinbad on 5/22/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class DiscoverMovieCell : UICollectionViewCell {
    
    var doscoverCollectionVC = DiscoverVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(doscoverCollectionVC.view)
        
        doscoverCollectionVC.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
