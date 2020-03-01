//
//  ScoresStandingsBuilder.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class ScoresStandingsBuilder {
    static func build() -> ScoresStandingsViewController {
        let storyboard = UIStoryboard(name: "ScoresStandings", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ScoresStandingsViewController") as! ScoresStandingsViewController
        viewController.viewModel = ScoresStandingsViewModel(service: app.scoresStandingsService)
        return viewController
    }
}
