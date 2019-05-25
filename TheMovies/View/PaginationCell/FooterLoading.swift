//
//  LoaderCell.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class FooterLoading : UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .red
        aiv.startAnimating()
        
        let loadigMore = UILabel(title: "Loading", color: .red, size: 16, textAlign: .center)
        loadigMore.textAlignment = .center
        let stackView = VerticalStackView(arranagedSubView: [aiv, loadigMore], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
