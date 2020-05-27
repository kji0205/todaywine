//
//  QuizViewController2.swift
//  todaywine
//
//  Created by jimmy on 2020/02/23.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class QuizViewController: UIViewControllerBase {
    
    @IBOutlet private weak var questionText: UILabel!
    @IBOutlet private weak var answerTrue: UIButton!
    @IBOutlet private weak var answerFalse: UIButton!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    private var store = DataStore.sharedInstance
    
    let quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        questionText.layer.cornerRadius = 10
        questionText.layer.masksToBounds = true
        
        exitButton.layer.cornerRadius = 10
        exitButton.layer.masksToBounds = true
        
        exitButton.isHidden = true
        
        showTheNextQuiz()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func actionCorrectCheck(_ sender: UIButton) {
        
        if !quizBrain.quizIndexCheck() {
            showEndQuiz()
            return
        }
        
        guard let answer = sender.currentTitle else {
            return
        }
        let result = quizBrain.takeQuiz(userAnswer: answer == "O")
        
        let alert = UIAlertController(title: nil, message: result ? "정답입니다":"틀렸습니다", preferredStyle: .alert)
        
        self.descriptionLabel.text = quizBrain.currentQuizDescription
        
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            self.quizBrain.getTheNextQuiz()
            if self.quizBrain.quizIndexCheck() {
                self.showTheNextQuiz()
            } else {
                self.showEndQuiz()
                return
            }
//            self.btnToggle()
        })
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        save(answer == "O", quizBrain.answerToTheCurrentQuiz)
        
    }
    
    // MARK: 문제를 다 풀었을 경우
    private func showEndQuiz() {
        let alert = UIAlertController(title: nil, message: "오늘의 문제를 다 푸셨습니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
//            self.navigationController?.popViewController(animated: true)
            self.exitButton.isHidden = false
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 다음 퀴즈 보여주기
    private func showTheNextQuiz() {
        self.questionText.text = quizBrain.currentQuiz
        self.questionText.sizeToFit()
    }
    
    // MARK: 퀴즈 기록 저장
    private func save(_ result: Bool, _ userAnswer: Bool) {
        
        let _quizLog = QuizLog.init(idx: 1, regdate: Date(), result: (result==userAnswer))
        
        self.store.quizLogs.append(_quizLog)
        
        do {
            let _quizLogData = try NSKeyedArchiver.archivedData(withRootObject: self.store.quizLogs, requiringSecureCoding: false)
            UserDefaults.standard.set(_quizLogData, forKey: "QuizLog")
            
        } catch  {
            print(error)
        }
    }
    
    
    private func btnToggle() {
        self.answerTrue.isEnabled = self.answerTrue.isEnabled ? false : true
        self.answerFalse.isEnabled = self.answerFalse.isEnabled ? false : true
    }
    
    @IBAction func exit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
