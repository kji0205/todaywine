//
//  MainViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MainViewController: UIViewControllerBase {
    
    private var wines: [Wine] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        let infoLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        infoLabel.text = "오늘의 와인"
        infoLabel.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(infoLabel)
        
        let mainViewTitle = UILabel()
        mainViewTitle.frame = CGRect(x: 150, y: 50, width: 100, height: 20)
        mainViewTitle.text = wines[wineIndex].name
        mainViewTitle.textAlignment = .center
        mainViewTitle.backgroundColor = .lightGray
        mainViewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainViewTitle)
        
        let marginGuide = view.layoutMarginsGuide
        
        mainViewTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 100).isActive = true
        mainViewTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        mainViewTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        mainViewTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let imageName = "cliff-lede.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 28).isActive = true
        
        let wineGrapeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        wineGrapeLabel.text = wines[wineIndex].grapes
        wineGrapeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(wineGrapeLabel)
        
        wineGrapeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        wineGrapeLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        wineGrapeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wineGrapeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 280).isActive = true
        
    }
}

