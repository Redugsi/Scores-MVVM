//
//  ScoresStandingsViewController.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class ScoresStandingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var scoresStanding: ScoresStandingsPresentation?
    
    public var viewModel: ScoresStandingsViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    let kCellHeight: CGFloat = 44
    let kHeaderHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.loadScoresStandings()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
    }
}

extension ScoresStandingsViewController: ScoresStandingsViewModelDelegate {
    func handleViewModelOutput(_ output: ScoresStandingsViewModelOutput) {
        switch output {
        case .showError(let error):
            switch error {
            case .networkError(internal: let internalError):
                showAlert(message: internalError.localizedDescription)
            case .serializationError(internal: let internalError):
                print(internalError.localizedDescription)
            }
        case .showScoresStandings(let presentation):
            self.scoresStanding = presentation
            tableView.reloadData()
        }
    }
}

extension ScoresStandingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresStanding?.scores.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return scoresStanding == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell") as! ScoreTableViewCell
        let shouldFill = (indexPath.row % 2) == 0
        cell.viewModel = ScoreTableViewCellModel(fill: shouldFill, score: scoresStanding!.scores[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scoresStanding?.date == nil ? 0 : kHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let kHeight: CGFloat = 18
        let kFontSize: CGFloat = 17
        let kLabelXPos: CGFloat = 10
        let labelYPos: CGFloat = (kHeaderHeight - kHeight) * 0.5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: kHeight))
        let label = UILabel(frame: CGRect(x: kLabelXPos, y: labelYPos, width: tableView.frame.size.width, height: kHeight))
        label.font = UIFont.boldSystemFont(ofSize: kFontSize)
        label.textColor = .white
        label.text = scoresStanding?.date ?? ""
        view.addSubview(label)
        view.backgroundColor = UIColor(named: "color_header")

        return view
    }
}
