//
//  NaviViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/05/24.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

@IBDesignable
class NaviViewController: UINavigationController {

    @IBInspectable
    private var navigationBarColor: UIColor = .white {
        didSet {
            self.navigationBar.backgroundColor = navigationBarColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.backgroundColor = navigationBarColor
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        
//        self.navigationController?.navigationBar.backgroundColor = .white
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = false

        // MARK: Logo
//        let logo = UIImage(named: "logo140.png")
//        let imageView = UIImageView(image: logo)
//        imageView.contentMode = .scaleAspectFit // set imageview's content mode
//        self.navigationItem.titleView = imageView
        
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
