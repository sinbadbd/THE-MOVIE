//
//  MovieCastCell.swift
//  TheMovies
//
//  Created by sinbad on 5/27/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class MovieCastCell : UICollectionViewCell {
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleNowPlayingMovie = UILabel(title: "Avenger", color: UIColor.black, textAlign: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5.0
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 80, height: 105))
        
        addSubview(titleNowPlayingMovie)
        titleNowPlayingMovie.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        titleNowPlayingMovie.numberOfLines = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
