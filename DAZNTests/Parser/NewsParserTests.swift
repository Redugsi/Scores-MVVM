//
//  NewsParserTests.swift
//  DAZNTests
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import XCTest

class NewsParserTests: XCTestCase {
    
    var sut: NewsParser!
    

    override func setUp() {
        loadXML()
    }
    
    private func loadXML() {
        do {
            if let xmlUrl = Bundle.main.url(forResource: "latestnews", withExtension: "xml") {
                let xml = try String(contentsOf: xmlUrl)
                sut = NewsParser(with: xml.data(using: .utf8)!)
            } else {
                preconditionFailure()
            }
            
        }catch {
            preconditionFailure()
        }
    }
    
    func testParse() {
        let news = sut.parse()
        XCTAssertTrue(news.count == 10)
        
        let first = news.first!
        XCTAssertTrue(first.title == "Lead story headline goes here")
        XCTAssertTrue(first.pubDate == "Tue, 01 Jan 2013 17:00:00 +0000")
        XCTAssertTrue(first.link == "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/webview/article.html/guid/100001")
        XCTAssertTrue(first.guid == 100001)
        XCTAssertTrue(first.imagePath == "http://www.mobilefeeds.performgroup.com/javaImages/4b/ce/0,,14012~11849291,00.jpg")
        XCTAssertTrue(first.description == "Lead story teaser text here")
        XCTAssertTrue(first.category == "News")
    }
}
