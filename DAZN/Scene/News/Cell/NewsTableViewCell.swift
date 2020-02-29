//
//  NewsTableViewCell.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel: NewsTableViewCellModel? {
        didSet {
            if let viewModel = viewModel {
                initView(with: viewModel)
            }
        }
    }
    
    private func initView(with viewModel: NewsTableViewCellModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        //newsImageView.image = nil
    }
    
}
