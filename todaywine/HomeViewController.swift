//
//  HomeViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/03/17.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var grapesLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var wines : [WineV2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWineData()
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
        
        nameLabel.text = wines[wineIndex].name
//        yearLabel.text = wines[wineIndex].year
        grapesLabel.text = wines[wineIndex].grapes
        countryLabel.text = wines[wineIndex].country
        regionLabel.text = wines[wineIndex].region
        descriptionLabel.text = wines[wineIndex].description
//        descriptionLabel.text = "Cabernet Sauvignon (French: [kabɛʁnɛ soviˈɲɔ̃]) is one of the world's most widely recognized red wine grape varieties. It is grown in nearly every major wine producing country among a diverse spectrum of climates from Canada's Okanagan Valley to Lebanon's Beqaa Valley.Cabernet Sauvignon (French: [kabɛʁnɛ soviˈɲɔ̃]) is one of the world's most widely recognized red wine grape varieties. It is grown in nearly every major wine producing country among a diverse spectrum of climates from Canada's Okanagan Valley to Lebanon's Beqaa Valley."
        
        descriptionLabel.sizeToFit()
        
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
