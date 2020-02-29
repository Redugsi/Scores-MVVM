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
    var newses: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        parseNews()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    private func parseNews() {
        do {
            if let xmlUrl = Bundle.main.url(forResource: "latestnews", withExtension: "xml") {
                let xml = try String(contentsOf: xmlUrl)
                let parser = NewsParser(with: xml.data(using: .utf8)!)
                self.newses = parser.parse()
                tableView.reloadData()
            }
            
        }catch {
            print(error)
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let news = newses[indexPath.row]
        cell.viewModel = NewsTableViewCellModel(title: news.title ?? "", date: news.pubDate ?? "", image: "perform")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    //TODO: Navigation Controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.show(NewsDetailBuilder.build(), sender: self)
    }
}
