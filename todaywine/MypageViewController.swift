//
//  MypageViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MypageViewController: UIViewControllerBase {
    
    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadQuizLog()
    }
    
    
    func loadQuizLog() {
            
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.store.quizLogs, requiringSecureCoding: false)
            print(data)
            
            if let ourData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [QuizLog] {
                print(ourData)
                self.store.quizLogs = ourData
            }
        } catch  {
            print(error)
        }
        
    }
}
