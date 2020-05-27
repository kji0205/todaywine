//
//  SetupViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/05/27.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    private var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func quizLogInit(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            self.store.quizLogs.removeAll()
            do {
                let _quizLogData = try NSKeyedArchiver.archivedData(withRootObject: self.store.quizLogs, requiringSecureCoding: false)
                UserDefaults.standard.set(_quizLogData, forKey: "QuizLog")
                
            } catch  {
                print(error)
            }
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
