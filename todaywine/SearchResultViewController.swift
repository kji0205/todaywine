//
//  SearchResultViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/03/03.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewControllerBase {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var grapesLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var kakaoMapView: UIView!
    
    var wineDataIndex: Int = 0
    var _name:String = ""
    var _region:String = ""
    var _grapes:String = ""
    var _country:String = ""
    var _description: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nameLabel.text = _name
        regionLabel.text = _region
        grapesLabel.text = _grapes
        countryLabel.text = _country
        descriptionLabel.text = _description
        
        kakaoMapView.addSubview(makeUIView())
        
        
    }

    func makeUIView() -> MTMapView {
        let view = MTMapView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
      view.currentLocationTrackingMode = .onWithoutHeading
      view.showCurrentLocationMarker = true
      
      return view
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(wineDataIndex)
//    }
    
    
}
