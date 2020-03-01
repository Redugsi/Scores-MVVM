//
//  NewsDetailViewController.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: NewsDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadNews()
    }
    
    private func setup() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            showLoader(isLoading: webView.isLoading)
        }
    }
    
    @IBAction func didDoneTap(_ sender: Any) {
        viewModel.done()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.isLoading))
    }
}

extension NewsDetailViewController: NewsDetailViewModelDelegate {
    func handleViewModelOutput(_ output: NewsDetailOutput) {
        switch output {
        case .showDetail(let request):
            webView.load(request)
        case .dismiss:
            dismiss(animated: true, completion: nil)
        case .showError(let error):
            switch error {
            case .urlNotFound(let description):
                showAlert(message: description, title: "Error")
            }
        }
    }
}
