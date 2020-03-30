//
//  SearchResultViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/03/03.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit
import MapKit

class SearchResultViewController: UIViewControllerBase {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var grapesLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var wineDataIndex: Int = 0
    var _name:String = ""
    var _region:String = ""
    var _grapes:String = ""
    var _country:String = ""
    var _description: String = ""
    
    // TODO
    var _latitude: CLLocationDegrees = 37.3794212
    var _longitude: CLLocationDegrees = 127.1120506
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nameLabel.text = _name
        regionLabel.text = _region
        grapesLabel.text = _grapes
        countryLabel.text = _country
        descriptionLabel.text = _description
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let location = CLLocation.init(latitude: _latitude, longitude: _longitude)
        performSegue(withIdentifier: "presentToMap", sender: location)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let mapViewController = segue.destination as? MapViewController,
        let location = sender as? CLLocation else { return }
        
        // 위도 경도 전달
        mapViewController.shopAddressLatitude = location.coordinate.latitude
        mapViewController.shopAddressLongitude = location.coordinate.longitude
    }
    
    
}
