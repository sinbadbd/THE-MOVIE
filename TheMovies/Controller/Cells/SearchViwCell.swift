//
//  SearchViwCell.swift
//  TheMovies
//
//  Created by sinbad on 6/28/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class SearchViwCell: UICollectionViewCell {
    
    
    let movieImg = UIImageView()
    let movieName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(movieImg)
        movieImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: movieImg.frame.width, height: 130))
        movieImg.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        movieImg.layer.cornerRadius = 8
        
        addSubview(movieName)
        movieName.anchor(top: movieImg.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: CGSize(width: movieName.frame.width, height: movieName.frame.height))
        movieName.numberOfLines = 3
        movieName.text = "Spider Man: Far Form Home"
        movieName.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
