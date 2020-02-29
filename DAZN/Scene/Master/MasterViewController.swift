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
    
    @IBOutlet weak var testView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(dropDownView)
        
        let newsViewModel = DefaultDropDownItemViewModel(title: "News")
        let scoresViewModel = DefaultDropDownItemViewModel(title: "Scores")
        
        dropDownView.delegate = self
        dropDownView.viewModel = DropDownViewModel(dropDownItemViewModels: [.standart(viewModel: newsViewModel),
                                                                            .standart(viewModel: scoresViewModel)])
    }
}

extension MasterViewController: DropDownViewDelegate {
    func onItemClicked(type: DropDownItemType, index: Int) {
        print("index \(index)")
        switch type {
        case .standart(let viewModel):
            print(viewModel.title)
        }
    }
}
