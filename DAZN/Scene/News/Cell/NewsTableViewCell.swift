//
//  NewsTableViewCell.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var viewModel: NewsPresentation? {
        didSet {
            if let viewModel = viewModel {
                initView(with: viewModel)
            }
        }
    }
    
    private func initView(with viewModel: NewsPresentation) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        newsImageView.loadImage(urlString: viewModel.imagePath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        newsImageView.image = nil
    }
    
}
