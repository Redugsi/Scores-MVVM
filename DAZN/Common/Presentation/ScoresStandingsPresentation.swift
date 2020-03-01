//
//  ScoresStandingsPresentation.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

public struct ScoresStandingsPresentation {
    let date: String?
    let scores: [ScorePresentation]
    
    init(date: String? = nil, scores: [ScorePresentation] = []) {
        self.date = date
        self.scores = scores
    }
}
