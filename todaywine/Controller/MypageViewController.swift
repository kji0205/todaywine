//
//  MypageViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MypageViewController: UIViewControllerBase {
    
    @IBOutlet private weak var quizHistoryLabel: UILabel!
    @IBOutlet private weak var searchHistoryLabel: UILabel!
    
    private var store = DataStore.sharedInstance
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizHistoryLabel.text = ""
        searchHistoryLabel.text = ""
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadQuizLog()
        loadSeachLog()
    }
    
    // MARK:- load Log
    private func loadQuizLog() {
        
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
    
    private func loadSeachLog() {
        
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
