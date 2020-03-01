//
//  MasterViewController.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {
    
    @IBOutlet private weak var dropDownView: DropDownView!
    @IBOutlet private weak var containerView: UIView!
        
    var viewModel: MasterViewModelProtocol! {
        didSet {
            viewModel?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropDownView()
        viewModel!.loadChildViewControllers()
        viewModel!.loadDropDownList()
    }
    
    private func setupDropDownView() {
        dropDownView.delegate = self        
        view.bringSubviewToFront(dropDownView)
    }
    
    private func addViewController(childViewController: UIViewController) {
        self.addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
}

extension MasterViewController: DropDownViewDelegate {
    func onItemClicked(type: DropDownItemType, index: Int) {
        viewModel.dropDownItemSelected(index: index)
    }
}

extension MasterViewController: MasterViewModelDelegate {
    func setChildViewControllers(with viewControllers: [UIViewController]) {
        viewControllers.forEach { addViewController(childViewController: $0)}
    }
    
    func setDropDownList(with dropDownViewModel: DropDownViewModel) {
        dropDownView.viewModel = dropDownViewModel
    }
    
    func showChild(at index: Int) {
        for(loopIndex, element) in containerView!.subviews.enumerated() {
            element.isHidden = loopIndex == index
        }
    }
}
