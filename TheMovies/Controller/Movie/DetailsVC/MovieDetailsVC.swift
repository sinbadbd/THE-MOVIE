//
//  MovieDetailsVC.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage
import YouTubePlayer

class MovieDetailsVC: UIViewController {
    
    let MOVIECAST_CELL = "MOVIECAST_CELL"
    
    var result = [Result]()
    var movieDetails : MovieDetails?
    var casts = [Cast]()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let topSliderImage: UIImageView = UIImageView()
    let movieTitleLabel :UILabel = UILabel()
    let playVedioButton: UIButton = UIButton(type: .system)
    let posterThumImage:UIImageView = UIImageView()
    
    let ratingMainView : UIView = UIView()
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let trackLayer: CAShapeLayer = CAShapeLayer()
    let movieOverViewContainer = UIView()
    let userScoreLabel: UILabel =  UILabel()
    
    //
    let favoriteButton : UIButton = UIButton()
    let wishlistButon : UIButton = UIButton()
    let ratedButton : UIButton = UIButton()
    
    let overviewTextLabel: UILabel = UILabel()
    let fullCastCrewLabel: UILabel = UILabel()
    let textlayer = CATextLayer()
    let basickAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    let backButton:UIButton = UIButton(type: .system)
    var id : Int! {
        didSet {
            print("id", id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
         setNavigationBar()
        setupScrollView()
        userButton()
        ratingView()
        
        collectionView.register(MovieCastCell.self, forCellWithReuseIdentifier: MOVIECAST_CELL)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchApiResponse()
        
        
    }
    func fetchApiResponse(){ //
        APIClient.getMovieId(id: 420818 ?? 0) { (response, error) in
            print("id----Movie id",self.id)
            if let response = response {
                self.movieDetails = response
                print(response)
                DispatchQueue.main.async {
                    if  response.backdropPath != nil {
                        let imgUrl = URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + response.backdropPath!)")
                        self.topSliderImage.sd_setImage(with: imgUrl, completed: nil)
                    }
                    if response.posterPath != nil {
                        let posterURL = URL(string: "\(APIClient.EndPoints.POSTER_URL + response.posterPath!)")
                        self.posterThumImage.sd_setImage(with: posterURL, completed: nil)
                        
                    }
                    self.movieTitleLabel.text = response.originalTitle
                    
                    
                    self.textlayer.string = "\(String(describing: response.voteAverage))"
                    self.basickAnimation.toValue = response.voteAverage
                    self.overviewTextLabel.text = response.overview
                    self.collectionView.reloadData()
                }
            }
        }
        
        
        // MOVIE CREDITS API CALL
        //movieCredit
        APIClient.getMovieCreditsId(id: id ?? 0) { (response, error) in
            print("id----movie credit id",self.id)
            if let response = response {
                self.casts = response[0].cast ?? []
               // print("credit\(response)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    func setupVedio(){
        let keyWindow = UIApplication.shared.keyWindow
        let height = (keyWindow?.frame.width)! * 9 / 16
        let vedioPlayerView = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: height)
        let vedioPlayer = VideoPlayerView(frame: vedioPlayerView)
        view.addSubview(vedioPlayer)
    }
    
    func setNavigationBar() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        topSliderImage.addSubview(backButton)
        backButton.anchor(top: topSliderImage.topAnchor, leading: topSliderImage.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 40, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        //backButton.backgroundColor = .blue
        backButton.isUserInteractionEnabled = true
        backButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButton.setImage(UIImage(named: "left-arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(handleBack(_:)), for: .touchUpInside)
    }
    
    @objc func handleBack(_ sender : UIButton){
        print("hi")
        let home = MovieController()
        self.present(home, animated: true, completion: nil)
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
            self.contentView.heightAnchor.constraint(equalToConstant: 1000)
            ])
        
        //To stop the scroll view horizontal scrolling, we are giving the same width for the content view as well
        self.view.addConstraints([
            self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            ])
       
        //
        topSliderImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topSliderImage)
        topSliderImage.backgroundColor = .red
        topSliderImage.isUserInteractionEnabled = true
        topSliderImage.contentMode = .scaleAspectFill
        topSliderImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(), size: CGSize(width: topSliderImage.frame.width, height: 280))
       //
        topSliderImage.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.text = "--"
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        movieTitleLabel.numberOfLines = 5
        movieTitleLabel.anchor(top: nil, leading: movieTitleLabel.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: topSliderImage.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 10), size: CGSize(width: 250, height: movieTitleLabel.frame.height))
        
        //
        topSliderImage.addSubview(posterThumImage)
        posterThumImage.translatesAutoresizingMaskIntoConstraints  = false
        posterThumImage.backgroundColor = .green
        posterThumImage.layer.cornerRadius = 12
        posterThumImage.layer.masksToBounds = true
        posterThumImage.clipsToBounds = true
        posterThumImage.layer.shadowRadius = 0.5
        posterThumImage.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        posterThumImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        posterThumImage.layer.shadowOpacity = 0.7
        posterThumImage.anchor(top: nil, leading: topSliderImage.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: -120, right: 0), size: CGSize(width: 120, height: 180))
      
        
        topSliderImage.addSubview(playVedioButton)
        playVedioButton.translatesAutoresizingMaskIntoConstraints = false
        playVedioButton.centerInSuperview()
        playVedioButton.backgroundColor = .red
        playVedioButton.setTitle("Play", for: .normal)
        playVedioButton.addTarget(self, action: #selector(handleVedioPlayer), for: .touchUpInside)
        playVedioButton.isUserInteractionEnabled = true

        
        contentView.addSubview(movieOverViewContainer)
        movieOverViewContainer.translatesAutoresizingMaskIntoConstraints = false
     //   movieOverViewContainer.backgroundColor = .blue
        movieOverViewContainer.anchor(top: topSliderImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 140, bottom: 0, right: 10), size: CGSize(width: 250, height: 100))
        
        
        movieOverViewContainer.addSubview(ratingMainView)
        ratingMainView.translatesAutoresizingMaskIntoConstraints = false
       // ratingMainView.backgroundColor = .blue
        ratingMainView.anchor(top: movieOverViewContainer.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 5), size: CGSize(width: 70, height: 70))
        
        
        movieOverViewContainer.addSubview(userScoreLabel)
        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        userScoreLabel.text = "User Score"
        userScoreLabel.font = UIFont.systemFont(ofSize: 12)
        userScoreLabel.textColor = .black
        userScoreLabel.textAlignment = .center
        userScoreLabel.anchor(top: ratingMainView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 70, height: userScoreLabel.frame.height))
 
        
        contentView.addSubview(overviewTextLabel)
        overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewTextLabel.text = "--"
       // overviewTextLabel.backgroundColor = .red
        overviewTextLabel.numberOfLines = 0
        overviewTextLabel.font = UIFont.systemFont(ofSize: 20)
        overviewTextLabel.anchor(top: ratingMainView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 60, left: 10, bottom: 40, right: 15), size: CGSize(width: overviewTextLabel.frame.width, height: overviewTextLabel.frame.height))
       
        
        contentView.addSubview(fullCastCrewLabel)
        fullCastCrewLabel.translatesAutoresizingMaskIntoConstraints = false
        fullCastCrewLabel.text = "Full Cast"
        //fullCastCrewLabel.backgroundColor = .blue
        fullCastCrewLabel.numberOfLines = 0
        fullCastCrewLabel.font = UIFont.boldSystemFont(ofSize: 24)
        fullCastCrewLabel.anchor(top: overviewTextLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 5, right: 15), size: CGSize(width: fullCastCrewLabel.frame.width, height: fullCastCrewLabel.frame.height))
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.anchor(top: fullCastCrewLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: collectionView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 40, right: 0), size: CGSize(width: collectionView.frame.width, height: 150))
    }
    func ratingView(){
        ratingMainView.layer.addSublayer(trackLayer)
        trackLayer.frame =  CGRect(x: 35, y: 35, width: 0, height: 0)
        let circularPath = UIBezierPath(arcCenter:  movieOverViewContainer.center , radius: 25, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 7
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        
        ratingMainView.layer.addSublayer(shapeLayer)
        shapeLayer.frame =  CGRect(x: 35, y: 35, width: 0, height: 0)
        // let circularPath = UIBezierPath(arcCenter:  movieOverView.center , radius: 35, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        shapeLayer.lineWidth = 7
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        
       
        //Animation#
        basickAnimation.toValue = 0.5
        basickAnimation.duration = 3
        basickAnimation.fillMode = .forwards
        basickAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basickAnimation, forKey: "Basic")
        
        textlayer.frame = CGRect(x: -20, y: -12, width: 40, height: 22)
        textlayer.fontSize = 20
        textlayer.alignmentMode = .center
        textlayer.isWrapped = true
        textlayer.foregroundColor = UIColor.black.cgColor
        shapeLayer.addSublayer(textlayer) // caLayer is and instance of parent CALayer
    }
    func userButton(){
        var colorValus = ["heart","bookmark-white","star"]
        var xOffest:CGFloat = 80
        for color in 0..<colorValus.count {
            let button = UIButton(frame: CGRect(x: xOffest, y: 10, width: 50, height: 50))
            xOffest += 55
            button.tag = color
            button.setImage(UIImage(named: "\(colorValus[color])"), for: .normal)
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.borderWidth = 3
            button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            
            button.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
            self.movieOverViewContainer.addSubview(button)
        }
        
        var titleValue = ["Adventure","Science Fiction","Action"]
        var xOffestT:CGFloat = 20
        for title in 0..<titleValue.count {
            let label = UILabel(frame: CGRect(x: xOffestT, y: 80, width: 300, height: 50))
            xOffestT += 80
            label.text = "\(titleValue[title])"
            //  self.movieOverViewContainer.addSubview(label)
        }
    }
    @objc func handleButton(_ sender: UIButton){
        print("hi")
        sender.buttonType.rawValue
        print(sender.tag)
        
    }
    
    @objc func handleVedioPlayer(_ sender: UIButton){
        print("hi--")
    }
   
}

extension MovieDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = casts[indexPath.item]
        let details = ArtistProfileVC()
        details.id = selected.id
        
        self.present(details, animated: true, completion: nil)
        print(details.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MOVIECAST_CELL, for: indexPath) as! MovieCastCell
        let apiResponse = casts[indexPath.item]
        if apiResponse.profilePath != nil {
            let img =  URL(string: "\(APIClient.EndPoints.PROFILE_URL + apiResponse.profilePath!)")
            cell.imageView.sd_setImage(with: img, completed: nil)
            cell.titleNowPlayingMovie.text = apiResponse.name
        } else {
            
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 140)
    }
}
