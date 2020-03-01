//
//  NewsViewControllerTests.swift
//  DAZNTests
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import XCTest

class NewsViewControllerTests: XCTestCase {
    
    var sut: NewsViewController!
    private var viewModel: MockViewModel!
    private var tableView: UITableView!
    
    override func setUp() {
        sut = NewsViewController()
        tableView = UITableView()
        sut.tableView = tableView
        viewModel = MockViewModel()
        sut.viewModel = viewModel
    }

    func testSetViewModel() {
        //When
        sut.viewModel = viewModel
        //Then
        XCTAssertTrue(viewModel.delegate != nil)
    }
    
    func testViewDidLoad() {
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertTrue(viewModel.loadNewsCalled)
    }
    
    func testTableViewItemClicked() {
        //Given
        sut.viewDidLoad()
        //When
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        //Then
        XCTAssertTrue(viewModel.selectNewsCalled)
    }
    
}

private class MockViewModel: NewsViewModelProtocol {
    var delegate: NewsViewModelDelegate?
    
    var loadNewsCalled = false
    var selectNewsCalled = false
    
    func loadNews() {
        loadNewsCalled = true
    }
    
    func selectNews(at index: Int) {
        selectNewsCalled = true
    }
}
