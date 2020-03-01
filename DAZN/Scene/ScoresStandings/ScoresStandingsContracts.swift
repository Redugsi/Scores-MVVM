//
//  ScoresStandingsContracts.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

protocol ScoresStandingsViewModelProtocol {
    var delegate: ScoresStandingsViewModelDelegate? { get set }
    func loadScoresStandings()
}

enum ScoresStandingsViewModelOutput {
    case showScoresStandings(ScoresStandingsPresentation)
    case showError(Error)
}

protocol ScoresStandingsViewModelDelegate: class {
    func handleViewModelOutput(_ output: ScoresStandingsViewModelOutput)
}
