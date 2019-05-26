//
//  Colors.swift
//  TheMovies
//
//  Created by sinbad on 5/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.locations = [0,1]
        gradientLayer.frame =  bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIButton {
    func setGradientButton(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame =  bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    func setRGBA(RED : Int, GREEN: Int, BLUE: Int, A: Float) -> UIColor {
        return UIColor(red: CGFloat(RED/255), green: CGFloat(GREEN/255), blue: CGFloat(BLUE/255), alpha: CGFloat(A))
    }
}
