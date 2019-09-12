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
    
    
    
    let artistView:UIView = UIView()
    let artistName:UILabel = UILabel()
    let artistDepartment:UILabel = UILabel()
    let artistImage:UIImageView = UIImageView()
    let artistDescription:UILabel = UILabel()
    let dateOfBirthLabel:UILabel = UILabel()
    
    let backButton:UIButton = UIButton(type: .system)
    
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
        setupView()
        setNavigationBar()
        
        colletionView.register(ProfileSliderCell.self, forCellWithReuseIdentifier: TOPSLIDER)
        colletionView.dataSource = self
        colletionView.delegate = self
        
        fetchAPI()
        
    }
    
    func fetchAPI(){ //2888: id
        APIClient.getArtistProfileId(id: id) { (response, error) in
            if let response = response {
                self.artist = response
                DispatchQueue.main.async {
                    self.artistName.text = response.name
                    self.artistDepartment.text = response.knownForDepartment
                    self.artistDescription.text = response.biography
                    self.dateOfBirthLabel.text = "Born: \(response.birthday ?? "" )"
                    if response.profilePath != nil {
                        let img = URL(string: "\(APIClient.EndPoints.PROFILE_FULL + response.profilePath!)")
                        self.artistImage.sd_setImage(with: img, completed: nil)
                    }
                   // self.colletionView.reloadData()
                }
            }
 
        }
        //2888 : id
        // TOP SLIDER IMAGE ß
        APIClient.getPersonImageId(id: id) { (response, error) in
            if let response = response {
                self.profile = response[0].profiles ?? []
                DispatchQueue.main.async {
                    self.colletionView.reloadData()
                }
            }
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 5
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
   
    func setNavigationBar() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)
        backButton.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 40, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        //backButton.backgroundColor = .blue
        backButton.isUserInteractionEnabled = true
        backButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButton.setImage(UIImage(named: "left-arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(handleBack(_:)), for: .touchUpInside)
    }
    
    @objc func handleBack(_ sender : UIButton){
        print("hi")
        let home = MovieDetailsVC()
        self.present(home, animated: true, completion: nil)
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
       // colletionView.backgroundColor = .white
        colletionView.backgroundColor = .white
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size : CGSize(width: colletionView.frame.width, height: 300))
        colletionView.addSubview(pageControl)
        pageControl.anchor(top: nil, leading: colletionView.leadingAnchor, bottom: colletionView.bottomAnchor, trailing: colletionView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 50, right: 0), size : CGSize(width: pageControl.frame.width, height: 40))
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        //pageControl.backgroundColor = .red
         pageControl.centerInSuperview()
        
    }
    
    func setupView(){
        contentView.addSubview(artistView)
        artistView.translatesAutoresizingMaskIntoConstraints = false
        artistView.backgroundColor = #colorLiteral(red: 0.2033947077, green: 0.2201191104, blue: 0.2415348346, alpha: 1)
        artistView.anchor(top: colletionView.bottomAnchor, leading: colletionView.leadingAnchor, bottom: nil, trailing: colletionView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: CGSize(width: artistView.frame.width, height: 250))
        artistView.addShadow(offset: CGSize(width: artistView.frame.width, height: -15), color: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), opacity: 0.7, radius: 25)
        
        artistView.addSubview(artistName)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.text = "--"
        artistName.textColor = .white
        artistName.font = UIFont.systemFont(ofSize: 30)
        artistName.anchor(top: artistView.topAnchor, leading: artistView.leadingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 15), size: CGSize(width: artistName.frame.width, height: artistName.frame.height))
        
        artistView.addSubview(artistDepartment)
        artistDepartment.translatesAutoresizingMaskIntoConstraints = false
        artistDepartment.text = "--"
        artistDepartment.textColor = #colorLiteral(red: 0.4411551162, green: 0.496842643, blue: 0.501960814, alpha: 1)
        artistDepartment.font = UIFont.systemFont(ofSize: 16)
        artistDepartment.anchor(top: artistName.bottomAnchor, leading: artistView.leadingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 15), size: CGSize(width: artistDepartment.frame.width, height: artistDepartment.frame.height))
        
        
        artistView.addSubview(artistImage)
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        artistImage.contentMode = .scaleAspectFit
        artistImage.layer.cornerRadius = 8
        artistImage.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        artistImage.anchor(top: artistDepartment.bottomAnchor, leading: artistView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 10, bottom: 0, right: 15), size: CGSize(width: 100, height: 150))
        
        
        
        artistView.addSubview(artistDescription)
        artistDescription.translatesAutoresizingMaskIntoConstraints = false
        artistDescription.numberOfLines = 5
        artistDescription.textColor = UIColor.white
        artistDescription.anchor(top: artistDepartment.bottomAnchor, leading: artistImage.trailingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15), size: CGSize(width: 250, height: artistDescription.frame.height))
        
        artistView.addSubview(dateOfBirthLabel)
        dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthLabel.numberOfLines = 1
        dateOfBirthLabel.textColor = UIColor.white
        dateOfBirthLabel.font = UIFont.systemFont(ofSize: 18)
        dateOfBirthLabel.anchor(top: artistDescription.bottomAnchor, leading: artistImage.trailingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15))
        
        
        let keyWindow = UIApplication.shared.keyWindow 
        let artistmovieList = ArtistMovieList()
        contentView.addSubview(artistmovieList)
        artistmovieList.translatesAutoresizingMaskIntoConstraints = false
        artistmovieList.anchor(top: artistView.bottomAnchor, leading: contentView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 0), size: CGSize(width: (keyWindow?.frame.width)!, height: 300))
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


