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
    
    func reloadList() {
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
        // Using seperate queue for network requests
        DispatchQueue.global(qos: .userInitiated).async {
            
            // No need to execute on main thread as the completion handler
            // is executed on main thread, specified in Network Client.
            
            self.useCases.fetchFeeds { [weak self] (resp, err) in
                if let response = resp {
                    self?.handleSuccess(title: response.title, feeds: response.rows)
                } else if let error = err {
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    private func handleSuccess(title: String, feeds: [Feed]?) {
        view?.setTitle(title)
        if let feeds = feeds {
            self.feeds = feeds
        }
        view?.hideLoader()
        view?.reloadTable()
        view?.displayNoResultsView(status: self.feeds.isEmpty)
    }
    
    private func handleError(error: Error) {
        view?.hideLoader()
        view?.displayNoResultsView(status: true)
        view?.showAlert(title: AppConstants.errorTitle, message: error.localizedDescription)
    }
    
}
