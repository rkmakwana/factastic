//
//  FeedsViewUILayout.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

extension FeedsViewController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = AppColors.primaryBackground
        safeArea = view.layoutMarginsGuide
        navigationBarAppearance()
        setupTableView()
    }
    
    func navigationBarAppearance() {
        self.title = AppConstants.title
        navigationController?.navigationBar.barTintColor = .systemGreen
        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
