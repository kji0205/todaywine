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
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizHistoryLabel.text = ""
        searchHistoryLabel.text = ""
        
        formatter.dateFormat = " yyyy년 MM월 dd일 HH시 mm분 "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadQuizLog()
        loadSeachLog()
    }
    
    // MARK:- load Log
    func loadQuizLog() {
        
        quizHistoryLabel.text = ""
        
        var _result: String
        var _answer: String
        
        for item in store.quizLogs.sorted() {
            _answer = item.result ? "[정답]" + "\n" : "[오답]" + "\n"
            _result = formatter.string(from: item.regdate) + " " + _answer
            quizHistoryLabel.text?.append(contentsOf: _result)
        }
        quizHistoryLabel.sizeToFit()
    }
    
    func loadSeachLog() {
        
        searchHistoryLabel.text = ""
        
        var _result: String
        var _answer: String
        var _searchKeyword: String
        
        for item in store.searchLogs.sorted() {
            _searchKeyword = item.searchKeyword
            _answer = item.result ? "(결과있음)" + "\n" : "(결과없음)" + "\n"
            _result = formatter.string(from: item.regdate) + " \"" + _searchKeyword + "\" " + _answer
            searchHistoryLabel.text?.append(contentsOf: _result)
        }
        searchHistoryLabel.sizeToFit()
    }
}
