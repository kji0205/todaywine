//
//  MyScoreViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/05/26.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class MyScoreViewController: UIViewControllerBase {

    private var store = DataStore.sharedInstance
    private let formatter = DateFormatter()
    @IBOutlet var scoreView: UIView!
    @IBOutlet var myScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.dateFormat = "yyyy-MM-dd HH:mm "
        scoreView.layer.cornerRadius = 10
        scoreView.layer.masksToBounds = true
        
        scoreView.layer.borderWidth = 7
        scoreView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
        
        let resultData = winPecent()
        
        myScore.text = String(resultData.0) + "%"
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
