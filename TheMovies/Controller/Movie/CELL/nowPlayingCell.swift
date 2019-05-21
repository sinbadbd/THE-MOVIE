//
//  nowPlayingCell.swift
//  TheMovies
//
//  Created by sinbad on 5/21/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class NowPlayingCell : UICollectionViewCell , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    
    
    
    let CELL = "CELL"
    
    let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        
        setUpView()
    }
    
    
    func setUpView(){
        colletionView.dataSource = self
        colletionView.delegate = self
        addSubview(colletionView)
        colletionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        colletionView.backgroundColor = .white
        colletionView.register(NowPlayCell.self, forCellWithReuseIdentifier: CELL)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL, for: indexPath) as! NowPlayCell
     
        cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 240)
    }


    
    class NowPlayCell : UICollectionViewCell {
        
        let imageView : UIImageView = {
            let image = UIImageView()
            image.layer.cornerRadius = 12
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            return image
        }()
        
        let titleNowPlaying = UILabel(title: "Avenger", color: UIColor.black, textAlign: .center)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .yellow
            imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: 140, height: 200))
            
            addSubview(titleNowPlaying)
            titleNowPlaying.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

