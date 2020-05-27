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

    private var store = DataStore.sharedInstance
    private lazy var todayScore = getMyQuizScoreToday()
    
    @IBInspectable
    @IBOutlet var startButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
        todayScore = getMyQuizScoreToday()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }

    private func setupUI() {
        startButton.layer.cornerRadius = 10 // * startButton.bounds.size.width
        startButton.layer.masksToBounds = true
        
        // MARK: 오늘 퀴즈를 푼 기록이 있을 경우
        if (todayScore.1 + todayScore.2) > 0 {
            
            startButton.isHidden = true
            
            let myScoreView = UIView(frame: CGRect(x: 10, y: 100, width: 350, height: 350))
            
            myScoreView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            myScoreView.layer.cornerRadius = 10
            myScoreView.layer.borderWidth = 10
            myScoreView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            myScoreView.tag = 21
            
            self.view.addSubview(myScoreView)

            myScoreView.translatesAutoresizingMaskIntoConstraints = false
            
            myScoreView.centerXAnchor
                .constraint(equalTo:view.centerXAnchor)
                .isActive = true
            myScoreView.centerYAnchor
                .constraint(equalTo:view.centerYAnchor)
                .isActive = true
            myScoreView.heightAnchor
                .constraint(equalToConstant: 300)
                .isActive = true
            myScoreView.widthAnchor
                .constraint(equalToConstant: 200)
                .isActive = true
            
            // 정답률 라벨
            let scoreLabel = UILabel()
            scoreLabel.text = "\(todayScore.0)%"
            scoreLabel.font = UIFont.systemFont(ofSize: CGFloat(50))
            myScoreView.addSubview(scoreLabel)
            
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            scoreLabel.centerXAnchor.constraint(equalTo: myScoreView.centerXAnchor)
                .isActive = true
            scoreLabel.centerYAnchor.constraint(equalTo: myScoreView.centerYAnchor)
                .isActive = true
            
            // 정답률 세부정보 라벨
            let scoreDescriptionLabel = UILabel()
            scoreDescriptionLabel.text = "(\(todayScore.1) / \(todayScore.2))"
            scoreDescriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(20))
            myScoreView.addSubview(scoreDescriptionLabel)
            scoreDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            scoreDescriptionLabel.topAnchor
                .constraint(equalTo: scoreLabel.bottomAnchor, constant: 8.0)
                .isActive = true
            scoreDescriptionLabel.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor)
                .isActive = true
            
        } else {
            startButton.isHidden = false
            self.view.viewWithTag(21)?.removeFromSuperview()
        }
    }
    
    // MARK: 오늘 퀴즈를 푼 스코어 확인
    private func getMyQuizScoreToday() -> (Int, Int, Int) {
        
        let todayScore = store.quizLogs.filter {
            return Calendar.current.isDate($0.regdate, equalTo: Date(), toGranularity: .day)
        }

        let fileteredTrue = todayScore.filter { $0.result }
        let fileteredFalse = todayScore.filter { !$0.result }
        
        var correctAnswerRate = 0
        
        if fileteredTrue.count > 0 {
            correctAnswerRate = Int((Float(fileteredTrue.count) / Float(todayScore.count)) * 100.0)
        }
        
        print("true count: \(fileteredTrue.count)")
        print("false count: \(fileteredFalse.count)")
        print("correctAnswerRate: \(correctAnswerRate)")
        
        return (correctAnswerRate, fileteredTrue.count, fileteredFalse.count)
        
    }
}
