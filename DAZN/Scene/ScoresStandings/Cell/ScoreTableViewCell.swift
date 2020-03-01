//
//  ScoreTableViewCell.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {
    
    static let filledBackgroundColor = UIColor(named: "color_gray")
    static let emptyBackgroundColor = UIColor(named: "color_white")

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var awayTeamLabel: UILabel!
    @IBOutlet private weak var homeTeamLabel: UILabel!
    
    var viewModel: ScoreTableViewCellModel? {
        didSet {
            if let viewModel = viewModel {
                initView(with: viewModel)
            }
        }
    }
    
    private func initView(with viewModel: ScoreTableViewCellModel) {
        contentView.backgroundColor = viewModel.fill ?
            ScoreTableViewCell.filledBackgroundColor : ScoreTableViewCell.emptyBackgroundColor
        scoreLabel.text = viewModel.score.score
        awayTeamLabel.text = viewModel.score.awayTeam
        homeTeamLabel.text = viewModel.score.homeTeam
    }
}
