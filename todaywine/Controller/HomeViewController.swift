//
//  HomeViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/03/17.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet var wineImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    //    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var grapesLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet var goToMapBtn: UIButton!
    
    private var wines : [Wine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWineData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: setWineData
    private func setWineData() {
        
        let hasURL = URL(string:  "\(API_URL_WINE)")!
        
        URLSession.shared.dataTask(with: hasURL) { (data, response, error) in
            
            guard let data = data else {
                let alert = UIAlertController.init(title: "와인 정보가 없음", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.wines = try decoder.decode([Wine].self, from: data)
//                print("quiz ==> \(self.wines)")
            } catch {
                print("error ==> \(error)")
            }
            
            DispatchQueue.main.async {
                let wineIndex = Int.random(in: 0...self.wines.count-1)
                
                if let imageUrl = self.wines[wineIndex].image {
                    self.wineImage.downloaded(from: imageUrl, contentMode: .scaleAspectFill)
                } else {
                    self.wineImage.image = UIImage(named: "wine-image-default")
                }
                
                self.nameLabel.text = self.wines[wineIndex].name
                //        self.yearLabel.text = self.wines[wineIndex].year
                self.grapesLabel.text = self.wines[wineIndex].grapes
                self.countryLabel.text = self.wines[wineIndex].country
                self.regionLabel.text = self.wines[wineIndex].region
                self.descriptionLabel.text = self.wines[wineIndex].description
            }
        }.resume()
        
        //        let jsonDecoder = JSONDecoder()
        //        guard let wineData : NSDataAsset = NSDataAsset(name: "wine") else {
        //            return
        //        }
        //        do {
        //            self.wines = try jsonDecoder.decode([Wine].self, from: wineData.data)
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        //        
        //        let wineIndex = Int.random(in: 0...wines.count-1)
        //        
        //        nameLabel.text = wines[wineIndex].name
        ////        yearLabel.text = wines[wineIndex].year
        //        grapesLabel.text = wines[wineIndex].grapes
        //        countryLabel.text = wines[wineIndex].country
        //        regionLabel.text = wines[wineIndex].region
        //        descriptionLabel.text = wines[wineIndex].description
        //        descriptionLabel.text = "Cabernet Sauvignon (French: [kabɛʁnɛ soviˈɲɔ̃]) is one of the world's most widely recognized red wine grape varieties. It is grown in nearly every major wine producing country among a diverse spectrum of climates from Canada's Okanagan Valley to Lebanon's Beqaa Valley.Cabernet Sauvignon (French: [kabɛʁnɛ soviˈɲɔ̃]) is one of the world's most widely recognized red wine grape varieties. It is grown in nearly every major wine producing country among a diverse spectrum of climates from Canada's Okanagan Valley to Lebanon's Beqaa Valley."
        
        descriptionLabel.sizeToFit()
        
    }
    
    var _latitude: CLLocationDegrees = 37.3794212
    var _longitude: CLLocationDegrees = 127.1120506
    
    @IBAction private func buttonPressed(_ sender: UIButton) {
        let location = CLLocation.init(latitude: _latitude, longitude: _longitude)
        performSegue(withIdentifier: "presentToMapByMain", sender: location)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let mapViewController = segue.destination as? MapViewController,
            let location = sender as? CLLocation else { return }
        
        // 위도 경도 전달
        mapViewController.shopAddressLatitude = location.coordinate.latitude
        mapViewController.shopAddressLongitude = location.coordinate.longitude
    }
    
}
