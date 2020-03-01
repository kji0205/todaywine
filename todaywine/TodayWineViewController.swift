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
    
    var wines : [Wine] = []
    
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
        
        nameLabel.text = wines[wineIndex].name
//        yearLabel.text = wines[wineIndex].year
        grapesLabel.text = wines[wineIndex].grapes
        countryLabel.text = wines[wineIndex].country
        regionLabel.text = wines[wineIndex].region
        descriptionLabel.text = wines[wineIndex].description
    }
}
