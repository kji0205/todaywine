//
//  SearchViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        infoLabel.text = "Search"
        infoLabel.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(infoLabel)
    }
}
