//
//  FeedsViewModelImplementation.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class FeedsViewModelImplementation: FeedsViewModel {
    
    private weak var view: FeedsView?
    private let useCases: FeedsUseCases!
    
    var feeds = [Feed]()
    
    init(view: FeedsView,
         useCases: FeedsUseCases) {
        self.view = view
        self.useCases = useCases
    }
    
    var numberOfRows: Int {
        feeds.count
    }
    
    func viewDidLoad() {
        view?.showLoader()
        fetchFeeds()
    }
    
    func fetchList() {
        fetchFeeds()
    }
    
    func reloadList() {
        view?.showLoader()
        fetchFeeds()
    }
    
    func configure(cell: FeedsCellView, for indexPath: IndexPath) {
        let feed = feeds[indexPath.row]
        cell.configure(with: feed)
    }
    
}

// MARK:- Private
extension FeedsViewModelImplementation {
    
    private func fetchFeeds() {
        useCases.fetchFeeds { (resp, err) in
            if let response = resp {
                self.handleSuccess(title: response.title, feeds: response.rows)
            } else if let error = err {
                self.handleError(error: error)
            }
        }
    }
    
    private func handleSuccess(title: String, feeds: [Feed]?) {
        view?.setTitle(title)
        if let feeds = feeds {
            self.feeds = feeds
        }
        view?.hideLoader()
        self.view?.reloadTable()
        self.view?.displayNoResultsView(status: self.feeds.isEmpty)
    }
    
    private func handleError(error: Error) {
        view?.hideLoader()
        self.view?.displayNoResultsView(status: true)
        self.view?.showAlert(title: AppConstants.errorTitle, message: error.localizedDescription)
    }
    
}
