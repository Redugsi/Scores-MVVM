//
//  NewsViewModel.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class NewsViewModel: NewsViewModelProtocol {
    weak var delegate: NewsViewModelDelegate?
    
    private let service: NewsServiceProtocol
    private var news: [News] = []
    
    init(service: NewsServiceProtocol) {
        self.service = service
    }
    
    func loadNews() {
        notify(.setLoading(true))
        service.getNews(completion: { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            switch result {
            case .success(let news):
                self.news = news
                let presentations = news.map { NewsPresentation(imagePath: $0.imagePath ?? "", title: $0.title ?? "", date: $0.pubDate ?? "")}
                self.notify(.showNews(presentations))
            case .failure(let error):
                //TODO: Error handle
                print(error)
            }
        })
    }
    
    func selectNews(at index: Int) {
        let choosedNews = news[index]
        let detailViewModel = NewsDetailViewModel(news: choosedNews)
        delegate?.navigate(to: .detail(detailViewModel))
    }
    
    private func notify(_ output: NewsViewModelOutput) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.handleViewModelOutput(output)
        }
    }
}
