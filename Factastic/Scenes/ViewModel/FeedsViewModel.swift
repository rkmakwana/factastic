//
//  FeedsViewModel.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol FeedsViewModel {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func reloadList()
    func configure(cell: FeedsCellView, for indexPath: IndexPath)
}
