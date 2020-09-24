//
//  FeedsView.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol FeedsView: class {
    func setTitle(_ title: String)
    func reloadTable()
    func showAlert(title: String, message: String)
    func showLoader()
    func hideLoader()
    func displayNoResultsView(status: Bool)
}
