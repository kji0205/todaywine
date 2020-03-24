//
//  MypageViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MypageViewController: UIViewControllerBase {
    
    @IBOutlet weak var quizHistoryLabel: UILabel!
    @IBOutlet weak var searchHistoryLabel: UILabel!
    
    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizHistoryLabel.text = ""
        searchHistoryLabel.text = ""
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
                var _result: String
                var _answer: String
                for item in self.store.quizLogs {
//                    quizHistoryLabel.text?.append(contentsOf: item.result ? "정답" + "\n" : "오답" + "\n")
//                    quizHistoryLabel.text?.append(contentsOf: item.regdate.description + "\n")
                    _answer = item.result ? "정답" + "\n" : "오답" + "\n"
                    _result = item.regdate.description + " " + _answer
                    quizHistoryLabel.text?.append(contentsOf: _result)
                }
            }
        } catch  {
            print(error)
        }
        
    }
}
