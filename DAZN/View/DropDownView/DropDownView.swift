//
//  DropDownView.swift
//  ParserTest
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

struct DropDownViewModel {
    var dropDownItemViewModels: [DropDownItemType]
}

class DropDownView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: DropDownViewModel? {
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
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func initView(with viewModel: DropDownViewModel) {
        clearStackView()
        fillStackView(with: viewModel.dropDownItemViewModels)
    }
    
    private func clearStackView() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
        }
    }
    
    func fillStackView(with types: [DropDownItemType]) {
        types.forEach {
            stackView.addArrangedSubview(createView(type: $0))
        }
    }
}

extension DropDownView: DropDownItemCreateProtocol {
    func createView(type: DropDownItemType) -> UIView {
        switch type {
        case .standart(let viewModel):
            let defaultItemView = DefaultDropDownItemView()
            defaultItemView.viewModel = viewModel
            return defaultItemView
        }
    }
}
