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
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let movieRatingLabel : UILabel  = UILabel()
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
       // setupVedio()
        
      //  let shapeLayer = CAShapeLayer()
        
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
        movieTitleLabel.text = "AVENGER"
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        movieTitleLabel.numberOfLines = 5
        movieTitleLabel.anchor(top: nil, leading: movieTitleLabel.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: topSliderImage.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 10), size: CGSize(width: 250, height: movieTitleLabel.frame.height))
        
        //
        topSliderImage.addSubview(posterThumImage)
        posterThumImage.translatesAutoresizingMaskIntoConstraints  = false
        posterThumImage.backgroundColor = .green
        posterThumImage.anchor(top: nil, leading: topSliderImage.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: -120, right: 0), size: CGSize(width: 120, height: 180))
        
        let movieOverView = UIView()
        contentView.addSubview(movieOverView)
        movieOverView.translatesAutoresizingMaskIntoConstraints = false
        //movieOverView.backgroundColor = .blue
        movieOverView.anchor(top: topSliderImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 140, bottom: 0, right: 10), size: CGSize(width: 250, height: 250))
        movieOverView.layer.addSublayer(shapeLayer)
        shapeLayer.frame =  CGRect(x: 50, y: 40, width: 0, height: 0)
        let circularPath = UIBezierPath(arcCenter:  movieOverView.center , radius: 35, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 7
        //shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        let basickAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basickAnimation.toValue = 1
        basickAnimation.duration = 5
        basickAnimation.fillMode = .forwards
        basickAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basickAnimation, forKey: "Basic")
        
        //shapeLayer.layer.addSublayer(movieRatingLabel)
        shapeLayer.insertSublayer(movieRatingLabel.layer, at: 0)
        movieRatingLabel.text = "8.5"
        movieRatingLabel.textColor = UIColor.yellow
        movieRatingLabel.frame = CGRect(x: movieRatingLabel.frame.origin.x , y: movieRatingLabel.frame.origin.y, width: movieRatingLabel.bounds.width, height: movieRatingLabel.bounds.height)

        movieRatingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
//        movieRatingLabel.centerInSuperview()
    }
    
    
}
