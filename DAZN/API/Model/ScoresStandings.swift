//
//  ScoresStandings.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

public struct ScoresStandings: CustomStringConvertible {
    var date: String?
    var scores: [Score] = []
    
    public var description: String {
        return "Date: \(date), scores: \(scores)"
    }
}

