//
//  QuizViewIntroViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/05/25.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

@IBDesignable
class QuizViewIntroViewController: UIViewController {

    @IBInspectable
    @IBOutlet var startButton: UIButton!
    
    @IBAction func quizStart(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.layer.cornerRadius = 10 // * startButton.bounds.size.width

        startButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
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
