//
//  Score.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

public struct Score: CustomStringConvertible {
    var homeTeam: String?
    var awayTeam: String?
    var homeTeamScore: String?
    var awayTeamScore: String?
    
    public var description: String {
        return "homeTeam: \(homeTeam), awayTeam: \(awayTeam), Home Score: \(homeTeamScore), Away Score: \(awayTeamScore)"
    }
}
