//
//  MovieDetailsVC.swift
//  TheMovies
//
//  Created by sinbad on 5/23/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import AVKit



class VedioPlayerView : UIView {
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    
    
    let controllerContainer: UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        controllerContainer.frame = frame
        addSubview(controllerContainer)
        
        controllerContainer.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        
    }
    
    
   func setupPlayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = NSURL(string: urlString) {
            let player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame =  self.frame
            player.play()
            
         //  player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanfs", options: .new, context: nil)
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                if player != nil && player.rate != 0 {
                    print("playing")
                    self.activityIndicatorView.stopAnimating()
                    self.controllerContainer.backgroundColor = .clear
                }
            }
            
            print(player)
        }
    }
   
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print(keyPath as Any)
//        if keyPath == "currentItem.loadedTimeRanfs" {
//            print(keyPath!)
//            activityIndicatorView.stopAnimating()
//            controllerContainer.backgroundColor = .clear
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MovieDetailsVC: UIViewController {
    
    var result = [Result]()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    
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
        setupVedio()
    }
    
    func setupVedio(){
        let keyWindow = UIApplication.shared.keyWindow
        let height = (keyWindow?.frame.width)! * 9 / 16
        let vedioPlayerView = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: height)
        let vedioPlayer = VedioPlayerView(frame: vedioPlayerView)
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
        //
        //
        //
        //        contentView.addSubview(vedioPlayerView)
        //        vedioPlayerView.translatesAutoresizingMaskIntoConstraints = false
        //        vedioPlayerView.anchor(top: contentView.topAnchor, leading: contentView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, size: CGSize(width: vedioPlayerView.frame.width, height: 280))
        //        print(vedioPlayerView)
    }
}
