//
//  UIViewController+Loading.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

extension UIViewController {
    var activityIndicatorTag: Int { return 59 }
    
    func showLoader(isLoading: Bool) {
        guard isLoading else {
            removeSpinner()
            return
        }
        addSpinner()
    }
    
    private func addSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.getSpinnerView() != nil {
                return
            }
            
            let spinnerView = UIView.init(frame: self.view.bounds)
            spinnerView.tag = self.activityIndicatorTag
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
    }
    
    private func removeSpinner() {
        DispatchQueue.main.async {[weak self] in
            if let activityIndicator = self?.getSpinnerView() {
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    private func getSpinnerView() -> UIView? {
        return self.view.subviews.filter(
            {
                $0.tag == self.activityIndicatorTag}
        ).first
    }
}
