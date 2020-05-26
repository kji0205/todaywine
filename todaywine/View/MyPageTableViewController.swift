//
//  MyPageTableViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/05/25.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MyPageTableViewController: UITableViewController {

    private var store = DataStore.sharedInstance 
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.quizLogs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        store.quizLogs.sort()
        let result = store.quizLogs[indexPath.row].result ? "정답" : "오답"
        let date = store.quizLogs[indexPath.row].regdate
        cell.textLabel?.text = "\(result)"
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let resultData = winPecent()
        return "퀴즈 정답률   \(resultData.0)%  (\(resultData.1) / \(store.quizLogs.count))"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60.0)
    }

    private func winPecent() -> (Int, Int, Int) {
        let fileteredTrue = store.quizLogs.filter {
            $0.result
        }
        let fileteredFalse = store.quizLogs.filter {
            !$0.result
        }
        print("true count: \(fileteredTrue.count)")
        print("false count: \(fileteredFalse.count)")
        
        var correctAnswerRate = 0
        
        if fileteredTrue.count > 0 {
            correctAnswerRate = Int((Float(fileteredTrue.count) / Float(store.quizLogs.count)) * 100)
        }
        
        return (correctAnswerRate, fileteredTrue.count, fileteredFalse.count)
    }
}
