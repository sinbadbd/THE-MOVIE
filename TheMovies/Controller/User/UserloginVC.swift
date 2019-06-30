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

    let usernameTextField : UITextField = UITextField()
    let passwordTextField : UITextField = UITextField()
    let loginButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 150, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 44))
        usernameTextField.backgroundColor = .white
        usernameTextField.layer.cornerRadius = 8
        usernameTextField.placeholder = "User name"
        
        let leftNameIcon =  UIImage(named: "like")

        usernameTextField.setLeftIcon(leftNameIcon!)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 44))
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.placeholder = "Password"
        passwordTextField.setLeftIcon(leftNameIcon!)
        passwordTextField.isSecureTextEntry = true
        
     
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20), size: CGSize(width: 240, height: 50))
        loginButton.layer.cornerRadius = 8
        loginButton.backgroundColor = UIColor(red: 219/255, green: 48/255, blue: 105/255, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        goProfileVC()
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
                    
                  //  print(username, password)
                    APIClient.login(username: username, password: password, completion: { (success, error) in
                        if success {
                            print("requestToken: \(APIClient.Auth.requestToken)")
                            APIClient.createSessionId(completion: { (success, error) in
                                if success {
                                    print("sessionId: \(APIClient.Auth.sessionId)")
                                    self.goProfileVC()
                                    //Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.goProfileVC), userInfo: nil, repeats: false)
                                }
                            })
                        }
                    })
                }
            }
        }
    }
    
     func goProfileVC(){
        let profile = UserProfileVC()
        self.present(profile, animated: true, completion: nil)
    }
}
