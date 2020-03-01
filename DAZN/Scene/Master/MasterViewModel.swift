//
//  MasterViewModel.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class MasterViewModel: MasterViewModelProtocol {
    weak var delegate: MasterViewModelDelegate?
    
    func loadChildViewControllers() {
        let viewControllersToLoad = [ScoresStandingsBuilder.build(), NewsBuilder.build()]
        delegate?.setChildViewControllers(with: viewControllersToLoad)
    }
    
    func loadDropDownList() {
        let newsViewModel = DefaultDropDownItemViewModel(title: "News")
        let scoresViewModel = DefaultDropDownItemViewModel(title: "Scores")
        
        let dropDownViewModel = DropDownViewModel(dropDownItemViewModels: [.standart(viewModel: newsViewModel),
                                                                           .standart(viewModel: scoresViewModel)])
        delegate?.setDropDownList(with: dropDownViewModel)
    }
    
    func dropDownItemSelected(index: Int) {
        delegate?.showChild(at: index)
    }
}
