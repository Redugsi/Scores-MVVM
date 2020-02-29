//
//  NewsBuilder.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class NewsBuilder {
    
    static func build() -> NewsViewController {
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        return viewController
    }
}
