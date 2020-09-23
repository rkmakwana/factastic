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
    
    let cellIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UITableView Datasource and Delegate

extension FeedsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
    
}
