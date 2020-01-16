//
//  PeopleTableViewController.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 15/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import UIKit

class PeopleTableViewController: AbstractPeopleTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load initial page
        self.fetchPeople()
    }
    
    override func configure() {
        super.configure()
    }
    
    private func fetchPeople(in page: Int = 1) {
        self.activityIndicatorView.startAnimating()
        self.apiPeopleGateway.fetchPeople(in: page) { (result) in
            switch result {
            case let .success(response):
                self.handlePeopleReceived(response: response)
            case let .fail(error):
                self.handlePeopleError(error)
            }
        }
    }
    
    // MARK: ScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMore(scrollView)
    }
    
    private func loadMore(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y // Y position of the content showing in scroll view
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height // Max Y position of the scroll view
        if (maxOffset - offset) <= 60 {
            self.fetchPeople(in: self.nextPage)
        }
    }

}
