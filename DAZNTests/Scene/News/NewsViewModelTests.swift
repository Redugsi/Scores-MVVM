//
//  NewsViewModelTests.swift
//  DAZNTests
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import XCTest

class NewsViewModelTests: XCTestCase {
    
    private var view: MockView!
    private var sut: NewsViewModel!
    private var successService: MockNewsSuccessService!
    private var failureService: MockNewsFailureService!

    override func setUp() {
        successService = MockNewsSuccessService()
        failureService = MockNewsFailureService()
        sut = NewsViewModel(service: successService)
        view = MockView()
        sut.delegate = view
    }
    
    func testLoadNewsWithSuccess() {
        //When
        sut.loadNews()
        //Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.view.setLoadingCalled)
            XCTAssertTrue(self.view.showNewsCalled)
            XCTAssertTrue(self.view.news.count == self.successService.news.count)
        }
    }
    
    func testLoadNewsWithFailure() {
        //Given
        sut = NewsViewModel(service: failureService)
        view = MockView()
        sut.delegate = view
        //When
        sut.loadNews()
        //Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.view.showErrorCalled)
        }
    }
    
    func testLoadNewsWithError() {
        
        //When
        sut.loadNews()
        //Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.view.setLoadingCalled)
            XCTAssertTrue(self.view.showNewsCalled)
            XCTAssertTrue(self.view.news.count == self.successService.news.count)
        }
    }
    
    func testSelectNews() {
        sut.loadNews()
        sut.selectNews(at: 0)
        XCTAssertTrue(view.navigateDetailCalled)
    }
}

private class MockView: NewsViewModelDelegate {
    var setLoadingCalled: Bool = false
    var showNewsCalled: Bool = false
    var showErrorCalled: Bool = false
    var navigateDetailCalled: Bool = false
    
    
    var news: [NewsPresentation] = []
    
    func handleViewModelOutput(_ output: NewsViewModelOutput) {
        switch output {
        case .setLoading(_):
            setLoadingCalled = true
        case .showNews(let news):
            self.news = news
            showNewsCalled = true
        case .showError(_):
            showErrorCalled = true
        }
    }
    
    func navigate(to route: NewsViewRoute) {
        navigateDetailCalled = true
    }
}
