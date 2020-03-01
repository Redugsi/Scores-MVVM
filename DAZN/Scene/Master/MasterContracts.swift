//
//  MasterContracts.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

protocol MasterViewModelProtocol {
    var delegate: MasterViewModelDelegate? { get set }
    func loadChildViewControllers()
    func loadDropDownList()
    func dropDownItemSelected(index: Int)
}

protocol MasterViewModelDelegate: class {
    func setChildViewControllers(with viewControllers: [UIViewController])
    func setDropDownList(with dropDownViewModel: DropDownViewModel)
    func showChild(at index: Int)
}
