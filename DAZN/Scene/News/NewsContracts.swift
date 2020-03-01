//
//  NewsContract.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

protocol NewsViewModelProtocol {
    var delegate: NewsViewModelDelegate? { get set }
    func loadNews()
    func selectNews(at index: Int)
}

enum NewsViewModelOutput {
    case showNews([NewsPresentation])
    case setLoading(Bool)
}

enum NewsViewRoute {
    case detail(NewsDetailViewModelProtocol)
}

protocol NewsViewModelDelegate: class {
    func handleViewModelOutput(_ output: NewsViewModelOutput)
    func navigate(to route: NewsViewRoute)
}
