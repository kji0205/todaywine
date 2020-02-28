//
//  MainViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MainViewController: UIViewControllerBase {
    
    var wines: [Wine] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        infoLabel.text = "Home"
        infoLabel.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(infoLabel)
        
        let mainViewTitle = UILabel()
        mainViewTitle.frame = CGRect(x: 150, y: 150, width: 100, height: 20)
        mainViewTitle.text = "MAIN VIEW"
        mainViewTitle.textAlignment = .center
        mainViewTitle.backgroundColor = .lightGray
        mainViewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainViewTitle)
        
        let marginGuide = view.layoutMarginsGuide
        
        mainViewTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 200).isActive = true
        mainViewTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        mainViewTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        mainViewTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
//        NSLayoutConstraint.activate([
//         mainViewTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//         mainViewTitle.widthAnchor.constraint(equalToConstant: 300.0),
//         mainViewTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 300.0),
//         mainViewTitle.heightAnchor.constraint(equalToConstant: 80.0)
//        ])
        
//        NSLayoutConstraint([
//            mainViewTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20),
//            mainViewTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
//            mainViewTitle.heightAnchor.constraint(equalToConstant: CGFloat(20)),
//            mainViewTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
//        ])
        
//        mainViewTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
//        mainViewTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        let jsonDecoder = JSONDecoder()
        guard let wineData : NSDataAsset = NSDataAsset(name: "wine") else {
            return
        }
        do {
            self.wines = try jsonDecoder.decode([Wine].self, from: wineData.data)
        } catch {
            print(error.localizedDescription)
        }
        
        let wineIndex = Int.random(in: 0...wines.count-1)
//        questionText.text = wines[wineIndex].name
        
    }
}

