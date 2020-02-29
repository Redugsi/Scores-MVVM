//
//  DropDownItem.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

protocol DropDownItemCreateProtocol {
    func createView(type: DropDownItemType) -> UIView
}

//Populate when new View created
enum DropDownItemType {
    case standart(viewModel: DefaultDropDownItemViewModel)
}
