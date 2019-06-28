//
//  PopularVC.swift
//  TheMovies
//
//  Created by sinbad on 5/22/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class PopularVC : UIViewController {
    
    private var nowPlaing : Movie?
    private var nowPlayArray = [Movie]()
    
    
    let POPULAR_CELL = "POPULAR_CELL"
    
    private let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    let NowPlayingMovieTitle = UILabel(title: "Popular Movies", color: .black, textAlign: .left)
    let nowPlayViewButton: UIButton = UIButton(type: .system)
    let topView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colletionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: POPULAR_CELL)
        
        setUpView()
        fetchData()
    }
    
    
    
    private var res = [Result]()
    
    private func fetchData (){
        APIClient.getPopularMovieList { (response, error) in
            
            if let response = response {
                //  print("Movie\(response)")
                DispatchQueue.main.async {
                    self.nowPlayArray = response
                    self.res = response[0].results
                    self.colletionView.reloadData()
                }
            }
        }
    }
    
    private func setUpView(){
        colletionView.dataSource = self
        colletionView.delegate = self
        view.addSubview(colletionView)
        colletionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: CGSize(width: colletionView.frame.width, height: colletionView.frame.height))
        colletionView.backgroundColor = .white
        
        
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        // topView.backgroundColor = .red
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 300, height: 40))
        
        
        topView.addSubview(NowPlayingMovieTitle)
        NowPlayingMovieTitle.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        NowPlayingMovieTitle.text = NowPlayingMovieTitle.text?.uppercased()
        NowPlayingMovieTitle.numberOfLines = 0
        NowPlayingMovieTitle.sizeToFit()
        NowPlayingMovieTitle.font = UIFont.systemFont(ofSize: 24)
        
        topView.addSubview(nowPlayViewButton)
        nowPlayViewButton.translatesAutoresizingMaskIntoConstraints = false
        nowPlayViewButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 100, height: nowPlayViewButton.frame.height))
        nowPlayViewButton.setTitle("View All", for: .normal)
        nowPlayViewButton.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
        nowPlayViewButton.setTitleColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), for: .normal)
        nowPlayViewButton.layer.borderWidth = 1
        nowPlayViewButton.layer.cornerRadius = 4
        nowPlayViewButton.backgroundColor = .white
        nowPlayViewButton.addTarget(self, action: #selector(hand), for: .touchUpInside)
    }
    @objc func hand(){
        print("hi")
        let vc =  PopularPagesVC()
        //  self.present(vc, animated: true, completion: nil)
    }
    
}

extension PopularVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return res.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = res[indexPath.item]
        let id = selected.id
        let details = MovieDetailsVC()
        details.id = id
        
        self.present(details, animated: true, completion: nil)
        //    self.navigationController?.pushViewController(details, animated: true)
        print(id)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: POPULAR_CELL, for: indexPath) as!  PopularMovieCell
        let apiData = res[indexPath.item]
        let imgUrl = URL(string: "\(APIClient.EndPoints.POSTER_URL + apiData.posterPath!)")
        cell.imageView.sd_setImage(with: imgUrl, completed: nil)
        cell.titleNowPlayingMovie.text = apiData.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
    }
}



class PopularMovieCell : UICollectionViewCell {
    
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
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5.0
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 140, height: 210))
        
        addSubview(titleNowPlayingMovie)
        titleNowPlayingMovie.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        titleNowPlayingMovie.numberOfLines = 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
