//
//  FavoriteListVC.swift
//  TheMovies
//
//  Created by sinbad on 7/1/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController {
    
    let tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    let FAVLIST = "FAVLIST"
    
    private var nowPlayArray = [Movie]()
    var result = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        
        
        APIClient.getFavoriteMovie { (response, error) in
           // print([response[0]])
            if let response = response {
                print(response)
                self.nowPlayArray = response
                self.result = response[0].results ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.result)
                }
            }
        }
        
        
//        APIClient.getFavoriteMovie { (response, error) in
//            //            if let response = response {
//            //              //  response[0].results
//            //                print(response[0].results as Any)
//            //            }
//            print("hiiii")
//            if let response = response {
//                  print("Movie::::::\(response)")
//                DispatchQueue.main.async {
//                    // self.nowPlayArray = response
//                    self.result = response
//                    print(self.result = response)
//                    self.tableView.reloadData()
//                }
//            }
//        }
        
        
        //        APIClient.getFavoriteMovie { (response, error) in
        //            print("hi===")
        //            if let response = response {
        //                self.result = response[0].results ?? []
        //               // print(response)
        //               // print(respons)
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            }
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FAVLIST)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init())
    }
}
extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("cont-----: \(result.count)")
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FAVLIST, for: indexPath)
        let apiRes = result[indexPath.item]
        cell.textLabel?.text = apiRes.originalTitle
        
        return cell
    }
    
    
}
