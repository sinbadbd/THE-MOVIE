//
//  ArtistProfileVC.swift
//  TheMovies
//
//  Created by sinbad on 5/29/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage

class ArtistProfileVC : UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let topSliderImage: UIImageView = UIImageView()
    
    let TOPSLIDER = "TOPSLIDER"
    
    private let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    var artist : Artist?
    var profile = [ProfileElement]()
    
    var id : Int! {
        didSet {
            print("id", id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        setupScrollView()
        
        colletionView.register(ProfileSliderCell.self, forCellWithReuseIdentifier: TOPSLIDER)
        colletionView.dataSource = self
        colletionView.delegate = self
        
        fetchAPI()
    }
    
    func fetchAPI(){
        APIClient.getArtistProfileId(id: id) { (response, error) in
            if let response = response {
                self.artist = response
                DispatchQueue.main.async {
                    self.colletionView.reloadData()
                }
            }
        }
        APIClient.getPersonImageId(id: id) { (response, error) in
            if let response = response {
                self.profile = response[0].profiles ?? []
                DispatchQueue.main.async {
                    self.colletionView.reloadData()
                }
            }
        }
    }
    
    
    func setupScrollView(){
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
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
            self.contentView.heightAnchor.constraint(equalToConstant: 1000)
            ])
        
        //To stop the scroll view horizontal scrolling, we are giving the same width for the content view as well
        self.view.addConstraints([
            self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            ])
        
        contentView.addSubview(colletionView)
        colletionView.backgroundColor = .white
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size : CGSize(width: colletionView.frame.width, height: 300))
    }
}

extension ArtistProfileVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TOPSLIDER, for: indexPath) as! ProfileSliderCell
       // cell.backgroundColor = .red
        let apiResponse = profile[indexPath.item]
       // if apiResponse.profiles[0]. != nil {
            let img = URL(string: "\(APIClient.EndPoints.POSTER_URL + apiResponse.filePath!)")
            cell.imageSlider.sd_setImage(with: img, completed: nil)
      //  }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
}
