//
//  SearchVC.swift
//  TheMovies
//
//  Created by sinbad on 6/24/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage

class SearchVC: UIViewController , UISearchBarDelegate {

    let searchbarController = UISearchController(searchResultsController: nil)
    
    let SEARCH = "SEARCH"
    
    var result = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchController()
        
        
        view.addSubview(collectionSearch)
        collectionSearch.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: collectionSearch.frame.width, height: collectionSearch.frame.height))
        collectionSearch.backgroundColor = .white
        
        collectionSearch.register(SearchViwCell.self, forCellWithReuseIdentifier: SEARCH)
        collectionSearch.delegate = self
        collectionSearch.dataSource = self
     
        
    }
    
    func setupSearchController(){
        definesPresentationContext = true
        navigationItem.searchController = self.searchbarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchbarController.dimsBackgroundDuringPresentation = false
        searchbarController.searchBar.delegate = self
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        APIClient.searchMovie(query: searchText) { (response, error) in
            if let response = response {
                self.result = response[0].results
                DispatchQueue.main.async {
                    self.collectionSearch.reloadData()
                } 
                print(response)
            }
        }
    }
    

    let collectionSearch : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
  
}

extension SearchVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let selected = result[indexPath.item]
        let id = selected.id
        let details = MovieDetailsVC()
        details.id = id
        
        self.present(details, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(result.count)
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSearch.dequeueReusableCell(withReuseIdentifier: SEARCH, for: indexPath) as! SearchViwCell
       
        let api = result[indexPath.item]
        if api.posterPath != nil {
            let imgUrl = URL(string: "\(APIClient.EndPoints.POSTER_URL + api.posterPath!)")
            cell.movieImg.sd_setImage(with: imgUrl, completed: nil)
        }
        cell.movieName.text = api.title
        
        return cell
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 3 - 48, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
