//
//  FiVerticalStackViewle.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arranagedSubView : [UIView], spacing: CGFloat = 0 ) {
        super.init(frame: .zero)
        arranagedSubView.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
