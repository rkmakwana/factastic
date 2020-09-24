//
//  FeedsViewModelTests.swift
//  FactasticTests
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import XCTest
@testable import Factastic

class FeedsViewModelTests: XCTestCase {
    
    let feedsListViewMock = FeedsViewMock()
    let feedsUseCasesMock = FeedsUseCasesMock()
    let feedsTableCellMock = FeedsTableCellMock()
    var viewModel: FeedsViewModelImplementation!
    
    // MARK: - Set up
    override func setUp() {
        super.setUp()
        viewModel = FeedsViewModelImplementation(view: feedsListViewMock,
                                                 useCases: feedsUseCasesMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_fetches_feeds_and_refreshes_list() {
        // Given
        let expectedFeedsCount = 6
        let feedsToBeFetched = Feed.createFeedList(numberOfItems: expectedFeedsCount)
        let response = FetchFeedsRequestResponse(title: "Random Facts", rows: feedsToBeFetched)
        feedsUseCasesMock.responseToBeReturned = response
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(feedsListViewMock.listRefreshed, "Refresh TableView not called")
    }
    
    func test_viewDidLoad_fetches_feeds_and_stops_loader() {
        // Given
        let expectedFeedsCount = 2
        let feedsToBeFetched = Feed.createFeedList(numberOfItems: expectedFeedsCount)
        let response = FetchFeedsRequestResponse(title: "Random Facts", rows: feedsToBeFetched)
        feedsUseCasesMock.responseToBeReturned = response
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertFalse(feedsListViewMock.loaderVisibile, "Loader is not hidden on list refresh")
    }
    
    func test_no_results_view_shown_on_empty_results() {
        // Given
        let response = FetchFeedsRequestResponse(title: "Random Facts", rows: nil)
        feedsUseCasesMock.responseToBeReturned = response
        
        // When
        viewModel.reloadList()
        
        // Then
        XCTAssertTrue(feedsListViewMock.displayingNoResultsView, "No results view not shown on empty results")
    }
    
    func test_error_message_displayed_on_error() {
        //Given
        let errorDescription = "Internet connection appers to be offline"
        let error = CustomError(str: errorDescription)
        feedsUseCasesMock.errorToReturn = error
        
        // When
        viewModel.reloadList()
        // Then
        XCTAssertEqual(feedsListViewMock.displayErrorMessage, errorDescription, "Error message is not as expected")
    }
    
    func test_title_updated_after_getting_results() {
        //Given
        let title = "Super fun facts"
        let response = FetchFeedsRequestResponse(title: title, rows: Feed.createFeedList(numberOfItems: 2))
        feedsUseCasesMock.responseToBeReturned = response
        
        //When
        viewModel.reloadList()
        
        //Then
        XCTAssertEqual(feedsListViewMock.navigationBarTitle, title, "Navigation title is not as expected")
    }
    
    func test_refresh_control_ends_refreshing() {
        //Given
        let response = FetchFeedsRequestResponse(title: "Random Facts", rows: nil)
        feedsUseCasesMock.responseToBeReturned = response
        
        //When
        viewModel.reloadList()
        
        //Then
        XCTAssertFalse(feedsListViewMock.refreshControlLoading, "Pull to refresh not ending after refreshing the list")
    }
    
    func test_configuration_table_view_cell() {
        //Given
        let rows = Feed.createFeedList(numberOfItems: 8)
        viewModel.feeds = rows
        let testFeedAtRow4 = rows[4]
        
        //When
        viewModel.configure(cell: feedsTableCellMock, for: IndexPath(row: 4, section: 0))
        
        //Then
        XCTAssertEqual(feedsTableCellMock.displayedFeed?.topic, testFeedAtRow4.topic, "Displaying incorrect titile at table index")
        XCTAssertEqual(feedsTableCellMock.displayedFeed?.detail, testFeedAtRow4.detail, "Displaying incorrect description at table index")
    }
    
    func test_table_view_cell_with_nil_feed_attributes() {
        //Given
        let feed = try! Feed.createEmptyFeed()
        viewModel.feeds = [feed]
        let testFeedAtRow0 = feed
        let feedTopic = "Untitled"
        let feedDetail = "No description provided"
        
        //When
        viewModel.configure(cell: feedsTableCellMock, for: IndexPath(row: 0, section: 0))
        
        //Then
        XCTAssertEqual(feedTopic, testFeedAtRow0.topic, "Displaying incorrect titile at table index for nil title")
        XCTAssertEqual(feedDetail, testFeedAtRow0.detail, "Displaying incorrect description at table index for nil detail")
    }
}
