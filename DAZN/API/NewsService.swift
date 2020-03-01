//
//  NewsService.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

public protocol NewsServiceProtocol {
    func getNews(completion: @escaping (Result<[News]>) -> Void)
}

public class NewsService: NewsServiceProtocol {
    public func getNews(completion: @escaping (Result<[News]>) -> Void) {
        let urlString = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/latestnews.xml"
        let request = URLRequest(url: URL(string: urlString)!)
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ (data, response, error) in
            
            if let error = error {
                completion(.failure(Error.networkError(internal: error)))
                return
            }
            
            guard let data = data else {
                return
            }
            
            let parser = NewsParser(with: data)
            let newses = parser.parse()
            
            if let parseError = parser.error {
                completion(.failure(.serializationError(internal: parseError)))
                return
            }
            
            completion(.success(newses))
        })
        
        task.resume()
    }
}
