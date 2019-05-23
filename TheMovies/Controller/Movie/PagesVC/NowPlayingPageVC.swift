//
//  NowPlayingPageVC.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class NowPlayingPageVC: UIViewController {
    
    let NOWPLAY_CELL = "NOWPLAY_CELL"
    private var nowPlaing : MovieResult?
    private var nowPlayArray = [MovieResult]()
    private var res = [Result]()
    
    private let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        colletionView.register(NowPlay.self, forCellWithReuseIdentifier: NOWPLAY_CELL)
        
        setUpView()
        fetchData()
        
        addNavigationBar()
    }
    func fetchData(){
        
    }
    private func addNavigationBar(){
        let height: CGFloat = 100
        let statusBarHeight = UIApplication.shared.statusBarFrame.height;
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self as? UINavigationBarDelegate
        
        let navItem = UINavigationItem()
        navItem.title = "Now Playing"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(handleBackButton))
        //        navItem.rightBarButtonItem = UIBarButtonItem(title: "Right Button", style: .plain, target: self, action: nil)
        
        navbar.items = [navItem]
        view.addSubview(navbar)
        self.view?.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
    }
    
    @objc func handleBackButton(){
        let back = MovieController()
        self.present(back, animated: true, completion: nil)
        //   self.navigationController?.present(back, animated: true, completion: nil)
    }
    
    private func setUpView(){
        colletionView.dataSource = self
        colletionView.delegate = self
        view.addSubview(colletionView)
        colletionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: CGSize(width: colletionView.frame.width, height: colletionView.frame.height))
        colletionView.backgroundColor = .white
        
        
    }
    
}

extension NowPlayingPageVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return res.count
        
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("now playing")
            let selectId = res[indexPath.item]
            let id = selectId.id
            
            
            print(id)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = colletionView.dequeueReusableCell(withReuseIdentifier: NOWPLAY_CELL, for: indexPath) as!  PopularMovieCell
            let apiData = res[indexPath.item]
            let imgUrl = URL(string: "\(APIClient.EndPoints.POSTER_URL + apiData.posterPath)")
            cell.imageView.sd_setImage(with: imgUrl, completed: nil)
            cell.titleMovieResult.text = apiData.title
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 140, height: 300)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        }
    }

 class NowPlay : UICollectionViewCell {
        
        let imageView : UIImageView = {
            let image = UIImageView()
            image.layer.cornerRadius = 8
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            return image
        }()
        
        let titleMovieResult = UILabel(title: "Avenger", color: UIColor.black, textAlign: .center)
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .yellow
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
            imageView.layer.shadowOpacity = 0.7
            imageView.layer.shadowRadius = 5.0
            imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 140, height: 210))
            
            addSubview(titleMovieResult)
            titleMovieResult.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
            titleMovieResult.numberOfLines = 3
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

