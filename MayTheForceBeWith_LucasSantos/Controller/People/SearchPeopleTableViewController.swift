//
//  SearchPeopleTableViewController.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 15/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import UIKit

private let reuseIdentifier = "peopleTableViewCell"

class SearchPeopleTableViewController: AbstractPeopleTableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController: UISearchController!
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchViewController()
    }
    
    private func configureSearchViewController() {
        self.searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.white
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    func searchPeople(by name: String) {
        self.activityIndicatorView.startAnimating()
        self.apiPeopleGateway.fetchPeople(by: name) { (result) in
            switch result {
                case let .success(response):
                    self.handlePeopleReceived(response: response)
                case let .fail(error):
                    self.handlePeopleError(error)
            }
        }
    }
    
    // MARK: - Search Bar Methods
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        guard let name = self.searchController.searchBar.text, name.count >= 3 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.searchPeople(by: name)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let _ = self.timer, let name = searchBar.text else { return }
        self.searchPeople(by: name)
    }

}
