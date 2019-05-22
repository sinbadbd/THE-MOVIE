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
    let PopularCell = "PopularCell"
    let TopRated = "TopRatedMovieCell"
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let collectionViewMain : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView() 
        
        collectionViewMain.delegate = self
        collectionViewMain.dataSource = self
        collectionViewMain.register(MovieResultCell.self, forCellWithReuseIdentifier: NOW_CELL)
        collectionViewMain.register(PopularMoviesCell.self, forCellWithReuseIdentifier: PopularCell)
        collectionViewMain.register(TopRatedMovieCell.self, forCellWithReuseIdentifier: TopRated)
        
        collectionViewMain.alwaysBounceHorizontal = true
        collectionViewMain.backgroundColor  = .white
        
        
        DispatchQueue.main.async {
            self.collectionViewMain.reloadData()
        }
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
         
        contentView.addSubview(collectionViewMain)
        contentView.backgroundColor = .white
        collectionViewMain.translatesAutoresizingMaskIntoConstraints = false
        collectionViewMain.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 0, right: 0), size: CGSize(width: collectionViewMain.frame.width, height: 900))
        
    }
    
    
}
// Now Playing
extension MovieController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }  else if section == 1{
            return 1
        } else {
            return 1
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: NOW_CELL, for: indexPath) as! MovieResultCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: PopularCell, for: indexPath) as! PopularMoviesCell
            return cell
        } else {
            let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: TopRated, for: indexPath) as! TopRatedMovieCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewMain.frame.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        } else if section == 1 {
            return UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        }
    }
    
}
