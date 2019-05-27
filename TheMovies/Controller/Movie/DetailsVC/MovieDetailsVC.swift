//
//  MovieDetailsVC.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
 
class MovieDetailsVC: UIViewController {
    
    var result = [Result]()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let topSliderImage: UIImageView = UIImageView()
    let movieTitleLabel :UILabel = UILabel()
    let playVedioButton: UIButton = UIButton()
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
    
    
    
    var id : Int? {
        didSet {
            print("id", id)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        // setNavigationBar()
        setupScrollView()
        userButton()
        ratingView()

    }
    
    func setupVedio(){
        let keyWindow = UIApplication.shared.keyWindow
        let height = (keyWindow?.frame.width)! * 9 / 16
        let vedioPlayerView = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: height)
        let vedioPlayer = VideoPlayerView(frame: vedioPlayerView)
        view.addSubview(vedioPlayer)
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let statusBarHeight = UIApplication.shared.statusBarFrame.height;
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: screenSize.width, height: 200))
        let navItem = UINavigationItem(title: "Details")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(handleBack))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        navBar.delegate = self as? UINavigationBarDelegate
        self.view.addSubview(navBar)
    }
    
    @objc func handleBack(){
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
            ])
        
        //To stop the scroll view horizontal scrolling, we are giving the same width for the content view as well
        self.view.addConstraints([
            self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            ])
       
        //
        topSliderImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topSliderImage)
        topSliderImage.backgroundColor = .red
        topSliderImage.contentMode = .scaleAspectFit
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
        posterThumImage.anchor(top: nil, leading: topSliderImage.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: -120, right: 0), size: CGSize(width: 120, height: 180))
        posterThumImage.layer.cornerRadius = 4
      
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
 
        let overviewTextLabel = UILabel()
        contentView.addSubview(overviewTextLabel)
        overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewTextLabel.text = "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos' actions and restore order to the universe once and for all, no matter what consequences may be in store."
       // overviewTextLabel.backgroundColor = .red
        overviewTextLabel.numberOfLines = 0
        overviewTextLabel.font = UIFont.systemFont(ofSize: 20)
        overviewTextLabel.anchor(top: ratingMainView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 60, left: 10, bottom: 0, right: 15), size: CGSize(width: overviewTextLabel.frame.width, height: overviewTextLabel.frame.height))
       
        let fullCastCrewLabel = UILabel()
        contentView.addSubview(fullCastCrewLabel)
        fullCastCrewLabel.translatesAutoresizingMaskIntoConstraints = false
        fullCastCrewLabel.text = "Full Cast & Crew"
        //fullCastCrewLabel.backgroundColor = .blue
        fullCastCrewLabel.numberOfLines = 0
        fullCastCrewLabel.font = UIFont.boldSystemFont(ofSize: 24)
        fullCastCrewLabel.anchor(top: overviewTextLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 15), size: CGSize(width: fullCastCrewLabel.frame.width, height: fullCastCrewLabel.frame.height))
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
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        
        let basickAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basickAnimation.toValue = 0.7
        basickAnimation.duration = 5
        basickAnimation.fillMode = .forwards
        basickAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basickAnimation, forKey: "Basic")
        
        
        let textlayer = CATextLayer()
        textlayer.frame = CGRect(x: -20, y: -12, width: 40, height: 22)
        textlayer.fontSize = 20
        textlayer.alignmentMode = .center
        textlayer.string = "9.3"
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
   
}

