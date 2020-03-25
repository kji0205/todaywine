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
        
        quizHistoryLabel.text = ""
        
        var _result: String
        var _answer: String
        
        for item in self.store.quizLogs.sorted() {
            _answer = item.result ? "정답" + "\n" : "오답" + "\n"
            _result = item.regdate.description + " " + _answer
            quizHistoryLabel.text?.append(contentsOf: _result)
        }
        
    }
}
