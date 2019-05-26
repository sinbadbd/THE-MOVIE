//
//  VideoPlayerView.swift
//  TheMovies
//
//  Created by sinbad on 5/26/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerView : UIView {
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pauseButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let controllerContainer: UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    let VideoRunTime : UILabel = {
        let label  = UILabel()
        label.text =  "00.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    let videoLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "00.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let videoSlider : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.widthAnchor.constraint(equalToConstant: 280).isActive = true
        slider.addTarget(self, action: #selector(handleVideioSlider), for: .touchUpInside)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        controllerContainer.frame = frame
        addSubview(controllerContainer)
        
        controllerContainer.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        controllerContainer.addSubview(pauseButton)
        pauseButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: 60, height: 60) )
        pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        pauseButton.centerInSuperview()
        pauseButton.tintColor = .white
        pauseButton.addTarget(self, action: #selector(handlePauseBtn), for: .touchUpInside)
        pauseButton.isHidden = true
        
        let stackview = UIStackView(arrangedSubviews: [VideoRunTime, videoSlider,videoLengthLabel])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        controllerContainer.addSubview(stackview)
        stackview.anchor(top: nil, leading: controllerContainer.leadingAnchor, bottom: controllerContainer.bottomAnchor, trailing: controllerContainer.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 10))
    }
    var isPlaying = false
    
    @objc func handleVideioSlider(){
        print(videoSlider.value)
        if let duration = player?.currentItem?.asset.duration {
            let totalSecond = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value)  * totalSecond
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (_) in
                
            })
        }
    }
    @objc func handlePauseBtn(){
        if isPlaying {
            player?.pause()
            pauseButton.setImage(UIImage(named: "play-button"), for: .normal)
        } else {
            player?.play()
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    var player : AVPlayer?
    func setupPlayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = NSURL(string: urlString) {
            player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame =  self.frame
            player?.play()
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                if self.player != nil && self.player?.rate != 0 {
                    print("playing")
                    self.activityIndicatorView.stopAnimating()
                    self.controllerContainer.backgroundColor = .clear
                    self.pauseButton.isHidden = false
                    self.isPlaying = true
                    
                    // TIME TRACK
                    let interval = CMTime(value: 1, timescale: 2)
                    self.player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] (progressTime) in
                        let seconds = CMTimeGetSeconds(progressTime)
                        let secondsString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))
                        let minutesString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))
                        self?.VideoRunTime.text =  "\(minutesString):\(secondsString)"
                        print(seconds)
                        
                        if let duration = self!.player?.currentItem?.asset.duration{
                            let durationSecond = CMTimeGetSeconds(duration)
                            self!.videoSlider.value = Float(seconds / durationSecond)
                        }
                    })
                    
                    
                    // TOTAL TIME
                    if let duration = self.player?.currentItem?.asset.duration { //.asset.duration ###
                        let seconds = CMTimeGetSeconds(duration)
                        
                        if seconds.isFinite{
                            let second = Int(seconds)
                            let secondsText = second % 60
                            var secondString = "00"
                            if secondsText < 10{
                                secondString = "0\(secondsText)"
                            }
                            else{
                                secondString = "\(secondsText)"
                            }
                            let minutesText = String(format: "%02d", Int(seconds) / 60)
                            self.videoLengthLabel.text =  "\(minutesText):\(secondString)"
                            print(self.videoLengthLabel)
                            
                        }
                    }
                }
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

