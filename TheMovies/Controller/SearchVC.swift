//
//  SearchVC.swift
//  TheMovies
//
//  Created by sinbad on 6/24/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class SearchVC: UIViewController , UISearchBarDelegate {

    let searchbarController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchController()
    }
    func setupSearchController(){
        definesPresentationContext = true
        navigationItem.searchController = self.searchbarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchbarController.dimsBackgroundDuringPresentation = false
        searchbarController.searchBar.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
