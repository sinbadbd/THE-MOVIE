//
//  MovieController.swift
//  TheMovies
//
//  Created by sinbad on 5/21/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class MovieController : UIViewController {
    
    let NOW_CELL  = "NOW_CELL"
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    let nowPlayingTitle = UILabel(title: "Now Playing", color: .black, textAlign: .left)
    let nowPlayViewButton: UIButton = UIButton(type: .system)
    
    
    let collectionViewNowPlaying : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setUpView()
        
        collectionViewNowPlaying.delegate = self
        collectionViewNowPlaying.dataSource = self
        collectionViewNowPlaying.register(NowPlayingCell.self, forCellWithReuseIdentifier: "NOW_CELL")
    }
    
    func setupScrollView(){
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        self.view.addConstraints([
            //Obsereve here for the top constraint, As given safeAreaLayoutGuide for not to conflict with the status bar
            //As this is especially useful for the X-series devices as they have top notch area
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ])
       // self.scrollView.contentInsetAdjustmentBehavior = .never
        
        self.scrollView.addSubview(contentView)
        self.scrollView.addConstraints([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            ])
        
        //To stop the scroll view horizontal scrolling, we are giving the same width for the content view as well
        self.view.addConstraints([
            self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            ])
    }
    
    
    
    
    func setUpView(){
        
        contentView.addSubview(nowPlayingTitle)
        nowPlayingTitle.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 0), size: CGSize(width: 100, height: nowPlayingTitle.frame.height))
        nowPlayingTitle.text = nowPlayingTitle.text?.uppercased()
        nowPlayingTitle.numberOfLines = 0
        nowPlayingTitle.sizeToFit()
        nowPlayingTitle.font = UIFont.systemFont(ofSize: 24)
        
        contentView.addSubview(nowPlayViewButton)
        nowPlayViewButton.translatesAutoresizingMaskIntoConstraints = false
        nowPlayViewButton.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: CGSize(width: 100, height: nowPlayViewButton.frame.height))
        nowPlayViewButton.setTitle("View All", for: .normal)
        nowPlayViewButton.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
        nowPlayViewButton.setTitleColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), for: .normal)
        nowPlayViewButton.layer.borderWidth = 1
        nowPlayViewButton.layer.cornerRadius = 4
        nowPlayViewButton.backgroundColor = .white
        
        
        contentView.addSubview(collectionViewNowPlaying)
        collectionViewNowPlaying.translatesAutoresizingMaskIntoConstraints = false
        collectionViewNowPlaying.anchor(top: nowPlayViewButton.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 0, right: 0), size: CGSize(width: collectionViewNowPlaying.frame.width, height: 220))
    }
    
    
}
// Now Playing
extension MovieController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewNowPlaying.dequeueReusableCell(withReuseIdentifier: NOW_CELL, for: indexPath) as! NowPlayingCell
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 210)
    }
    
}
