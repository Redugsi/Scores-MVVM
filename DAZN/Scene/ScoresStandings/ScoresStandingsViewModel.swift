//
//  ScoresStandingsViewModel.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class ScoresStandingsViewModel: ScoresStandingsViewModelProtocol {
    weak var delegate: ScoresStandingsViewModelDelegate?
    private let service: ScoresStandingsServiceProtocol
    private var scoresStandings: ScoresStandings?
    private var timer: Timer?
    private let kRequestInterval: Double = 30
    
    init(service: ScoresStandingsServiceProtocol) {
        self.service = service
        setTimer()
    }
    
    @objc
    func loadScoresStandings() {
        service.getScoresStandings(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let standings):
                self.scoresStandings = standings ?? ScoresStandings(date: nil, scores: [])
                let presentationModel = self.createPresentation()
                self.notify(.showScoresStandings(presentationModel))
            case .failure(let error):
                self.notify(.showError(error))
            }
        })
    }
    
    private func setTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: kRequestInterval,
                                     target: self,
                                     selector: #selector(loadScoresStandings),
                                     userInfo: nil, repeats: true)
    }
    
    private func createPresentation() -> ScoresStandingsPresentation {
        var scoresPresentations: [ScorePresentation] = []
        
        
        if let scores = scoresStandings?.scores {
            scoresPresentations = scores.map{
                ScorePresentation(homeTeam: $0.homeTeam ?? "", awayTeam: $0.awayTeam ?? "",
                                  score: "\($0.homeTeamScore ?? "0") - \($0.awayTeamScore ?? "0")")}
        }
        
        return ScoresStandingsPresentation(date: scoresStandings?.date?.toReadableDate() ?? "", scores: scoresPresentations)
    }
    
    private func notify(_ output: ScoresStandingsViewModelOutput) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.handleViewModelOutput(output)
        }
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}
