//
//  ProfileSliderCell.swift
//  TheMovies
//
//  Created by sinbad on 5/29/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class ProfileSliderCell : UICollectionViewCell {
    let imageSlider : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageSlider)
       // imageSlider.backgroundColor = .blue
        imageSlider.contentMode = .scaleAspectFill
        imageSlider.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageSlider.translatesAutoresizingMaskIntoConstraints = false
        
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
