//
//  MockNewsSuccessService.swift
//  DAZNTests
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class MockNewsSuccessService: NewsServiceProtocol {
    var news: [News] = [News(guid: 0, title: "title", pubDate: "pubDate", imagePath: "imagePath", description: "description", link: "link", category: "category"), News(guid: 1, title: "title1", pubDate: "pubDate1", imagePath: "imagePath1", description: "description1", link: "link1", category: "category1")]
    
    func getNews(completion: @escaping (Result<[News]>) -> Void) {
        completion(.success(news))
    }
}
