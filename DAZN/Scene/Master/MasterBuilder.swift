//
//  MasterBuilder.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class MasterBuilder {
    
    static func build() -> MasterViewController {
        let storyboard = UIStoryboard(name: "Master", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MasterViewController") as! MasterViewController
        viewController.viewModel = MasterViewModel()
        return viewController
    }
}
