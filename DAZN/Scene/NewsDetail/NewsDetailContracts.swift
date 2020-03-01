//
//  NewsDetailContracts.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

enum NewsDetailOutput {
    case showDetail(URLRequest)
    case showError(NewsDetailError)
    case dismiss
}

protocol NewsDetailViewModelDelegate: class {
    func handleViewModelOutput(_ output: NewsDetailOutput)
}

protocol NewsDetailViewModelProtocol {
    var delegate: NewsDetailViewModelDelegate? { get set }
    func loadNews()
    func done()
}
