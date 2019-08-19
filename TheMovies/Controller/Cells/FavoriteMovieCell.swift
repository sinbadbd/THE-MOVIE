//
//  FavoriteMovieCell.swift
//  TheMovies
//
//  Created by Zahedul Alam on 19/8/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage
class FavoriteMovieCell: UITableViewCell {

    let movieName : UILabel = UILabel()
    let movieImage: UIImageView = UIImageView()
    var movie : Result? {
        didSet{
            self.movieName.text = movie?.originalTitle
 
            let url = URL(string: "\(APIClient.EndPoints.POSTER_URL + (movie?.posterPath)!)")
            self.movieImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: CGSize(width: 120, height:  150))
        
        addSubview(movieName)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieName.anchor(top: topAnchor, leading: movieImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 5, right: 0), size: CGSize(width: movieName.frame.width, height: movieName.frame.height))
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
