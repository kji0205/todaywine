//
//  MypageViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MypageViewController: UIViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        infoLabel.text = "Mypage"
        infoLabel.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(infoLabel)
    }
    
    
}
