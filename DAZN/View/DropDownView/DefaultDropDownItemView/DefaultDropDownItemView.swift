//
//  DefaultDropDownItemView.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

struct DefaultDropDownItemViewModel {
    var title: String
}

final class DefaultDropDownItemView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: DefaultDropDownItemViewModel? {
        didSet {
            if let viewModel = viewModel {
                initView(with: viewModel)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func initView(with viewModel: DefaultDropDownItemViewModel) {
        titleLabel.text = viewModel.title
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DefaultDropDownItemView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
