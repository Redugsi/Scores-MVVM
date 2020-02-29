//
//  MasterViewController.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var dropDownView: DropDownView!
    
    @IBOutlet weak var testView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(dropDownView)
        
        let newsViewModel = DefaultDropDownItemViewModel(title: "News")
        let scoresViewModel = DefaultDropDownItemViewModel(title: "Scores")
        
        dropDownView.viewModel = DropDownViewModel(dropDownItemViewModels: [.standart(viewModel: newsViewModel),
                                                                            .standart(viewModel: scoresViewModel)])
        testView.isUserInteractionEnabled = true
        testView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didItemTap)))
    }
    
    
    @objc
    private func didItemTap(_ recognizer: UITapGestureRecognizer) {
        print("View Tap")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
