//
//  NewsDetailBuilder.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class NewsDetailBuilder {
    static func build() -> NewsDetailViewController {
        let storyboard = UIStoryboard(name: "NewsDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "NewsDetailViewController") as NewsDetailViewController
        return viewController
    }
}
