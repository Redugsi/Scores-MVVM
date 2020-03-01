//
//  ScoresStandingsParserTests.swift
//  DAZNTests
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import XCTest

class ScoresStandingsParserTests: XCTestCase {

    var sut: ScoresStandingParser!
    
    override func setUp() {
        loadXML()
    }
    
    private func loadXML() {
        do {
            if let xmlUrl = Bundle.main.url(forResource: "scores", withExtension: "xml") {
                let xml = try String(contentsOf: xmlUrl)
                sut = ScoresStandingParser(with: xml.data(using: .utf8)!)
            } else {
                preconditionFailure()
            }
            
        }catch {
            preconditionFailure()
        }
    }
    
    func testParse() {
        let scoreStandings = sut.parse()
        XCTAssertTrue(scoreStandings != nil)
        XCTAssertTrue(scoreStandings?.scores.count == 8)
        XCTAssertTrue(scoreStandings?.date == "2012-09-19")
        
        let first = scoreStandings?.scores.first
        XCTAssertTrue(first?.homeTeam == "Chelsea")
        XCTAssertTrue(first?.awayTeam == "Juventus")
        XCTAssertTrue(first?.homeTeamScore == "0")
        XCTAssertTrue(first?.awayTeamScore == "3")
    }

}
