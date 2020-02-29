//
//  DropDownView.swift
//  ParserTest
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

protocol DropDownViewDelegate {
    func onItemClicked(type: DropDownItemType, index: Int)
}

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
        load()
        addGestureToImage()
    }
    
    private func load() {
        Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func addGestureToImage() {
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didImageTap)))
    }
    
    @objc
    private func didImageTap(_ recognizer: UITapGestureRecognizer) {
        toggle()
    }
    
    private func initView(with viewModel: DropDownViewModel) {
        clearStackView()
        fillStackView(with: viewModel.dropDownItemViewModels)
    }
    
    @objc
    private func didItemTap(_ recognizer: UITapGestureRecognizer) {
        print("Tap Item")
    }
    
    private func clearStackView() {
        stackView.arrangedSubviews.dropFirst().forEach {
            stackView.removeArrangedSubview($0)
        }
    }
    
    func fillStackView(with types: [DropDownItemType]) {
        stackView.isUserInteractionEnabled = true
        types.forEach {
            let itemView = createView(type: $0)
            itemView.isUserInteractionEnabled = true
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didItemTap)))
            stackView.addArrangedSubview(itemView)
        }
    }
    
    func toggle() {
        stackView.arrangedSubviews.dropFirst().forEach {
            $0.isHidden = !$0.isHidden
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
