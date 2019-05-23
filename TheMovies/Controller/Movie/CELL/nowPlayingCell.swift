//
//  MovieResultCell.swift
//  TheMovies
//
//  Created by sinbad on 5/21/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage

class MovieResultCell : UICollectionViewCell   {
    
    var nowPlaying = NowPlayingVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nowPlaying.view)
        nowPlaying.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

