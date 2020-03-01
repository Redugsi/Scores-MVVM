//
//  NewsViewController.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NewsViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var presentations: [NewsPresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.loadNews()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
}

extension NewsViewController: NewsViewModelDelegate {
    func handleViewModelOutput(_ output: NewsViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            showLoader(isLoading: isLoading)
        case .showNews(let presentations):
            self.presentations = presentations
            tableView.reloadData()
        case .showError(let error):
            showAlert(message: error.localizedDescription)
        }
    }
    
    func navigate(to route: NewsViewRoute) {
        switch route {
        case .detail(let viewModel):
            show(NewsDetailBuilder.build(with: viewModel), sender: self)
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let presentation = presentations[indexPath.row]
        cell.viewModel = presentation
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectNews(at: indexPath.row)
    }
}
