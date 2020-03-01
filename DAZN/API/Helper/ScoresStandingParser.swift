//
//  ScoresStandingParser.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class ScoresStandingParser: NSObject {
    var xmlParser: XMLParser?
    var currentScoreStanding: ScoresStandings?
    
    var error: Swift.Error? {
        return xmlParser?.parserError
    }
    
    init(with data: Data) {
        xmlParser = XMLParser(data: data)
    }
    
    func parse() -> ScoresStandings? {
        xmlParser?.delegate = self
        xmlParser?.parse()
        return currentScoreStanding
    }
}

extension ScoresStandingParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "gsmrs" {
            currentScoreStanding = ScoresStandings()
        }
        
        if elementName == "parameter" {
            if attributeDict["name"] == "date", let date = attributeDict["value"] {
                currentScoreStanding?.date = date.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if elementName == "match" {
            var currentScore = Score()
            currentScore.awayTeam = attributeDict["team_B_name"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            currentScore.awayTeamScore = attributeDict["fs_B"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            currentScore.homeTeam = attributeDict["team_A_name"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            currentScore.homeTeamScore = attributeDict["fs_A"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            currentScoreStanding?.scores.append(currentScore)
        }
    }
}
