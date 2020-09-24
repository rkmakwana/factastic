//
//  FeedsViewController.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    let tableView = UITableView()
    var viewModel: FeedsViewModel!
    let refreshControl = UIRefreshControl()
    var noResultsView: UIView!
    var loader: UIActivityIndicatorView!
    
    let cellIdentifier = "cell"
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = FeedsViewModelImplementation(view: self,
                                                      useCases: FeedsUseCasesImplementation())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.reloadList()
    }
    
    @objc func retry(_ sender: Any?) {
        viewModel.fetchList()
    }

}

// MARK: - UITableView Datasource and Delegate

extension FeedsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedsTableViewCell
        viewModel.configure(cell: cell, for: indexPath)
        return cell
    }
    
}

// MARK:- FeedsView Protocol Conformance
extension FeedsViewController: FeedsView {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func reloadTable() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppConstants.okayAction,
                                      style: .default,
                                      handler: nil))
        
        // Presenting alert immediately after refresh control ends refreshing makes the header stuck
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            self.present(alert, animated: true)
        })
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
        refreshControl.endRefreshing()
    }
    
    func displayNoResultsView(status: Bool) {
        // If true, show no results view and hide table view, otherwise inverse
        if status {
            noResultsView.isHidden = false
            tableView.isHidden = true
        } else {
            noResultsView.isHidden = true
            tableView.isHidden = false
        }
    }
}

