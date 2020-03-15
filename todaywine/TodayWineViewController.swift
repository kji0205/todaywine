//
//  TodayWineViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/29.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class TodayWineViewController: UIViewControllerBase {
    
    
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var grapesLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var wines : [WineV2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        var newSafeArea = UIEdgeInsets()
        print(view.safeAreaInsets)
        
        setupLayout()
//        setWineData()
    }
    
    
    // MARK: setupLayout
    func setupLayout() {
        
        let contentView: UIView
        let contentScrollView: UIView
        
        
        // MARK: navigationBar
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: self.view.frame.width, height: 44))
        
        self.view.addSubview(navBar)

        let navItem = UINavigationItem(title: "오늘의 와인")
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(selectorName:))
//        navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)
        
        
        let guide = view.safeAreaLayoutGuide
//        UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
        contentView = UIView()
        contentView.frame = CGRect(x: self.view.safeAreaInsets.left, y: self.view.safeAreaInsets.top, width: 300, height: 300)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .green
        
        self.view.addSubview(contentView)
        
        print(guide)
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
//            contentView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
//            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 1.0)
//        ])
    }
    
    
    // MARK: setWineData
    func setWineData() {
        let jsonDecoder = JSONDecoder()
        guard let wineData : NSDataAsset = NSDataAsset(name: "wineV2") else {
            return
        }
        do {
            self.wines = try jsonDecoder.decode([WineV2].self, from: wineData.data)
        } catch {
            print(error.localizedDescription)
        }
        
        let wineIndex = Int.random(in: 0...wines.count-1)
        
        //        nameLabel.text = wines[wineIndex].name
        ////        yearLabel.text = wines[wineIndex].year
        //        grapesLabel.text = wines[wineIndex].grapes
        //        countryLabel.text = wines[wineIndex].country
        //        regionLabel.text = wines[wineIndex].region
        ////        descriptionLabel.text = wines[wineIndex].description
        //        descriptionLabel.text = "test - Cabernet Sauvignon (French: [kabɛʁnɛ soviˈɲɔ̃]) is one of the world's most widely recognized red wine grape varieties. It is grown in nearly every major wine producing country among a diverse spectrum of climates from Canada's Okanagan Valley to Lebanon's Beqaa Valley.Cabernet Sauvignon (French: [kabɛʁnɛ soviˈɲɔ̃]) is one of the world's most widely recognized red wine grape varieties. It is grown in nearly every major wine producing country among a diverse spectrum of climates from Canada's Okanagan Valley to Lebanon's Beqaa Valley."
                
    }
    

}
