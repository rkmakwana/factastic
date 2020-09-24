//
//  FeedsViewMock.swift
//  FactasticTests
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import Factastic

class FeedsViewMock: FeedsView {
    
    var listRefreshed = false
    var loaderVisibile = false
    var refreshControlLoading = true
    var navigationBarTitle: String?
    var displayErrorTitle: String?
    var displayErrorMessage: String?
    var displayingNoResultsView = false
    
    func showLoader() {
        loaderVisibile = true
    }
    
    func hideLoader() {
        loaderVisibile = false
        refreshControlLoading = false
    }
    
    func reloadTable() {
        listRefreshed = true
    }
    
    func setTitle(_ title: String) {
        navigationBarTitle = title
    }
    
    func showAlert(title: String, message: String) {
        displayErrorTitle = title
        displayErrorMessage = message
    }
    
    
    
    func displayNoResultsView(status: Bool) {
        displayingNoResultsView = status
    }
    
}
