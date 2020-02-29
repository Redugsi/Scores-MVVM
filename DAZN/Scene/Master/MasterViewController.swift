//
//  MasterViewController.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {

    @IBOutlet weak var dropDownView: DropDownView!
    @IBOutlet weak var containerView: UIView!
    
    weak var newsViewController: NewsViewController!
    weak var scoresStandingsViewController: ScoresStandingsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
        setupDropDownView()
    }
    
    private func setupChildViewControllers() {
        newsViewController = NewsBuilder.build()
        scoresStandingsViewController = ScoresStandingsBuilder.build()
        addViewController(childViewController: scoresStandingsViewController)
        addViewController(childViewController: newsViewController)
    }
    
    private func setupDropDownView() {
        let newsViewModel = DefaultDropDownItemViewModel(title: "News")
        let scoresViewModel = DefaultDropDownItemViewModel(title: "Scores")
        
        dropDownView.delegate = self
        dropDownView.viewModel = DropDownViewModel(dropDownItemViewModels: [.standart(viewModel: newsViewModel),
                                                                            .standart(viewModel: scoresViewModel)])
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
        for(loopIndex, element) in containerView!.subviews.enumerated() {
            element.isHidden = loopIndex == index
        }
    }
}
