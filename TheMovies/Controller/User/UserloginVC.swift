//
//  UserloginVC.swift
//  TheMovies
//
//  Created by sinbad on 6/30/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserloginVC: UIViewController {

    
    let loginView:UIView = UIView()
    let usernameTextField : UITextField = UITextField()
    let passwordTextField : UITextField = UITextField()
    let loginButton: UIButton = UIButton(type: .system)
    
    let bottomView:UIView = UIView()
    let btnLogin: UIButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
        
        view.addSubview(loginView)
        loginView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 200, left: 0, bottom: 0, right: 0), size: CGSize(width: loginView.frame.width, height: loginView.frame.size.height / 3))
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.backgroundColor = .white
       // loginView.wantsLayer = true
       // loginView.layer.zPosition = 0
        loginView.alpha = 0
        
        loginView.addSubview(usernameTextField)
        loginView.addSubview(passwordTextField)
        loginView.addSubview(loginButton)
        
        
        view.addSubview(bottomView)
        bottomView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: bottomView.frame.width, height: 200))
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.shadowColor = UIColor.darkGray.cgColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 5
        
        
        bottomView.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: bottomView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 44))
        btnLogin.layer.cornerRadius = 8
        btnLogin.backgroundColor = UIColor(red: 219/255, green: 48/255, blue: 105/255, alpha: 1)
        btnLogin.setTitle("Press to login!", for: .normal)
        btnLogin.addTarget(self, action: #selector(handleShowLoginView), for: .touchUpInside)
        btnLogin.setTitleColor(UIColor.white, for: .normal)

        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.anchor(top: loginView.topAnchor, leading: loginView.leadingAnchor, bottom: nil, trailing: loginView.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 44))
        usernameTextField.backgroundColor = .white
        usernameTextField.layer.cornerRadius = 8
        usernameTextField.placeholder = "User name"
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        usernameTextField.layer.borderWidth = 1
        
        let leftNameIcon =  UIImage(named: "avatar")

        usernameTextField.setLeftIcon(leftNameIcon!)
        
        
        let passworIcon =  UIImage(named: "lock-2") 
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, leading: loginView.leadingAnchor, bottom: nil, trailing: loginView.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 44))
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.placeholder = "Password"
        passwordTextField.setLeftIcon(passworIcon!)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1
     
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 50))
        loginButton.layer.cornerRadius = 8
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 219/255, green: 48/255, blue: 105/255, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        goProfileVC()
    }
    
    @objc func handleShowLoginView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
           // self.loginView.frame.origin.y = -20
            self.loginView.alpha = 1
            self.bottomView.alpha = 0
        }, completion: nil)
    }
    
    
    
    @objc func handleLoginButton(){
       // self.goProfileVC()
        SVProgressHUD.show()

        APIClient.getRequestToken { (success, error) in
            if success {
                //print(APIClient.Auth.requestToken)
                DispatchQueue.main.async {
                    let username = self.usernameTextField.text ?? ""
                    let password = self.passwordTextField.text ?? ""
                    let defaults = UserDefaults.standard

                    
                    if username == ""  || password == "" {
                        print("hi")
                        SVProgressHUD.dismiss()
                    }
                  //  print(username, password)
                    APIClient.login(username: username, password: password, completion: { (success, error) in
                        if success {
                            SVProgressHUD.dismiss()

                            print("requestToken: \(APIClient.Auth.requestToken)")
                            APIClient.createSessionId(completion: { (success, error) in
                                if success {
                                    let nameX = defaults.set(username, forKey: "name")
                                    defaults.set(password, forKey: "password")

                                   // print(nameX)
                                    let d = defaults.string(forKey: "name")
                                    let p = defaults.string(forKey: "password")

                                  //  print("get:\(d)\(p)")
                                    print("sessionId: \(APIClient.Auth.sessionId)")
                                    DispatchQueue.main.async{
                                        self.goProfileVC()
                                    }
                                    SVProgressHUD.dismiss()
                                }
                            })
                        }
                    })
                }
            }
        }
    }
    
     func goProfileVC(){
        let profile = BaseTabController()
        self.present(profile, animated: true, completion: nil)
    }
}
