//
//  NewsDetailViewModel.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    weak var delegate: NewsDetailViewModelDelegate?
    private let newsLink: String?
    
    init(news: News) {
        self.newsLink = news.link
    }
    
    func loadNews() {
        guard let link = newsLink, link != "", let url = URL(string: link) else {
            notify(.showError(.urlNotFound("Can not find")))
            return
        }
        
        let request = URLRequest(url: url)
        notify(.showDetail(request))
    }
    
    func done() {
        notify(.dismiss)
    }
    
    private func notify(_ output: NewsDetailOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

enum NewsDetailError: Swift.Error {
    case urlNotFound(String)
}
