//
//  DropDownViewTests.swift
//  DAZNTests
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import XCTest

class DropDownViewTests: XCTestCase {
    
    var sut: DropDownView!
    let dropDownItems = [DropDownItemType.standart(viewModel: DefaultDropDownItemViewModel(title: "First")),
                         DropDownItemType.standart(viewModel: DefaultDropDownItemViewModel(title: "Second"))]
    
    override func setUp() {
        sut = DropDownView()
    }
    
    func testSetViewModel() {
        XCTAssertTrue(sut.stackView.arrangedSubviews.count == 1)
        sut.viewModel = DropDownViewModel(dropDownItemViewModels: dropDownItems)
        XCTAssertTrue(sut.stackView.arrangedSubviews.count == dropDownItems.count + 1)
    }
    
    func testToggle() {
        sut.viewModel = DropDownViewModel(dropDownItemViewModels: dropDownItems)
        let isHiddenBeforeToggle = self.sut.stackView.arrangedSubviews.dropFirst().first(where: { $0.isHidden }) == nil
        XCTAssertTrue(self.sut.stackView.arrangedSubviews.count == (isHiddenBeforeToggle ? 1 : self.dropDownItems.count + 1))
        sut.toggle()
        let isHidenAfterToggle = self.sut.stackView.arrangedSubviews.dropFirst().first(where: { $0.isHidden }) == nil
        XCTAssertTrue(isHidenAfterToggle != isHiddenBeforeToggle)
    }
    
    func testOnItemClick() {
        sut.viewModel = DropDownViewModel(dropDownItemViewModels: dropDownItems)
        let mockView = MockDelegate()
        sut.delegate = mockView
        let isHiddenBeforeToggle = self.sut.stackView.arrangedSubviews.dropFirst().first(where: { $0.isHidden }) == nil
        
        if isHiddenBeforeToggle {
            sut.toggle()
        }
        
        let gesture = sut.stackView.arrangedSubviews[1].gestureRecognizers?[0]
        sut.didItemTap(gesture as! UITapGestureRecognizer)
        
        XCTAssertTrue(mockView.onItemClickedCalled)
    }
    
}

fileprivate class MockDelegate: DropDownViewDelegate {
    public var onItemClickedCalled = false
    
    func onItemClicked(type: DropDownItemType, index: Int) {
        onItemClickedCalled = true
    }
}
