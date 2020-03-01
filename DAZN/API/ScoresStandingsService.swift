//
//  ScoresStandingsService.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

public protocol ScoresStandingsServiceProtocol {
    func getScoresStandings(completion: @escaping (Result<ScoresStandings?>) -> Void)
}

public class ScoresStandingsService: ScoresStandingsServiceProtocol {
    public func getScoresStandings(completion: @escaping (Result<ScoresStandings?>) -> Void) {
        let urlString = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/scores.xml"
        let request = URLRequest(url: URL(string: urlString)!)
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ (data, response, error) in
            
            if let error = error {
                completion(.failure(Error.networkError(internal: error)))
                return
            }
            
            guard let data = data else {
                return
            }
            
            let parser = ScoresStandingParser(with: data)
            let scoresStandingModel = parser.parse()
            
            if let parseError = parser.error {
                completion(.failure(.serializationError(internal: parseError)))
                return
            }
            
            completion(.success(scoresStandingModel))
        })
        
        task.resume()
    }
}
