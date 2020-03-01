//
//  AppContainer.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    
    let newsService = NewsService()
    let scoresStandingsService = ScoresStandingsService()
    var imageCache = NSCache<AnyObject, AnyObject>()

}
