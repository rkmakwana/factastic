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
        title = AppConstants.title
        navigationBarAppearance()
        setupTableView()
        setupRefreshControl()
        setupNoFeedsView()
        setupLoader()
    }
    
    func navigationBarAppearance() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .systemGreen
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.barTintColor = .systemGreen
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
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
        
        tableView.register(FeedsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setupLoader() {
        if #available(iOS 13.0, *) {
            loader = UIActivityIndicatorView(style: .large)
        } else {
            loader = UIActivityIndicatorView(style: .gray)
        }
        loader.center = self.view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
    }
    
    func setupNoFeedsView() {
        let container = UIView()
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            container.topAnchor.constraint(equalTo: safeArea.topAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: ImageAssets.noResults)
        container.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -60),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let label = UILabel()
        label.text = "No results found"
        label.font = AppFonts.title
        label.textColor = .systemPink
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(retry(_:)), for: .touchUpInside)
        container.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        constraints = [
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        noResultsView = container
        noResultsView.isHidden = true
    }
}
