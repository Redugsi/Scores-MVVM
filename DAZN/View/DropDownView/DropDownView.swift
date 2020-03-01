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

final class DropDownView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    let choosedColor = UIColor(named: "color_blue")
    
    var delegate: DropDownViewDelegate?
    
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
    
    private func initView(with viewModel: DropDownViewModel) {
        clearStackView()
        fillStackView(with: viewModel.dropDownItemViewModels)
    }
    
    private func clearStackView() {
        stackView.arrangedSubviews.dropFirst().forEach {
            stackView.removeArrangedSubview($0)
        }
    }
    
    func fillStackView(with types: [DropDownItemType]) {
        stackView.isUserInteractionEnabled = true
        for (index, element) in types.enumerated(){
            let itemView = createView(type: element)
            itemView.isUserInteractionEnabled = true
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didItemTap)))
            itemView.tag = index
            itemView.isHidden = true
            stackView.addArrangedSubview(itemView)
        }
    }
    
    @objc
    private func didImageTap(_ recognizer: UITapGestureRecognizer) {
        toggle()
    }
    
    @objc
    func didItemTap(_ recognizer: UITapGestureRecognizer) {
        guard let selectedIndex = recognizer.view?.tag, let viewModel = viewModel else {
            return
        }
        
        guard selectedIndex < viewModel.dropDownItemViewModels.count else {
            return
        }
        
        let dropItemType = viewModel.dropDownItemViewModels[selectedIndex]
        delegate?.onItemClicked(type: dropItemType, index: selectedIndex)
        toggle()
    }
    
    func toggle() {
        stackView.arrangedSubviews.dropFirst().forEach {
            $0.isHidden = !$0.isHidden
        }
        setImageViewColor()
    }
    
    func setImageViewColor() {
        let isHidden = stackView.arrangedSubviews.dropFirst().first(where: { $0.isHidden }) != nil
        imageView.backgroundColor = isHidden ? UIColor.black : choosedColor
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
