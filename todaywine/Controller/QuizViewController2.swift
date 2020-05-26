//
//  QuizViewController2.swift
//  todaywine
//
//  Created by jimmy on 2020/02/23.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class QuizViewController2: UIViewControllerBase {
    
    @IBOutlet private weak var questionText: UILabel!
    @IBOutlet private weak var answerTrue: UIButton!
    @IBOutlet private weak var answerFalse: UIButton!
    @IBOutlet var exitButton: UIButton!
    
    
    private var quiz : [Quiz] = []
    private var currentAnswer: Bool = false
    
    private var userQuizIndex = 1
    private var userQuizCountMax = 5
    
    private var store = DataStore.sharedInstance
    
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("quizlog.archive")
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQuizData()
        
        navigationController?.isNavigationBarHidden = true
        
        questionText.layer.cornerRadius = 10
        questionText.layer.masksToBounds = true
        
        exitButton.layer.cornerRadius = 10
        exitButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func actionTrue(_ sender: Any) {
        
        if quizIndexCheck() {
            return
        }
        let alert = UIAlertController(title: nil, message: currentAnswer ? "정답입니다":"틀렸습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            self.nextQuizData()
            self.btnToggle()
        })
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        save(true, currentAnswer)
        
    }
    
    @IBAction private func actionFalse(_ sender: Any) {
        
        if quizIndexCheck() {
            self.btnToggle()
            return
        }
        
        let alert = UIAlertController(title: nil, message: currentAnswer ? "틀렸습니다":"정답입니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            self.nextQuizData()
            self.btnToggle()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        save(false, currentAnswer)
    }
    
    // 문제수 체크
    private func quizIndexCheck() -> Bool {
        
        btnToggle()
        
        if quiz.count > self.userQuizIndex, self.userQuizIndex <= self.userQuizCountMax {
            self.userQuizIndex += 1
            return false
        } else {
            let alert = UIAlertController(title: nil, message: "오늘의 문제를 다 푸셨습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return true
        }
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
    
    // MARK: 퀴즈 정보 로드
    private func getQuizData() {
        
        //        let quizURLString = "https://raw.githubusercontent.com/kji0205/todaywine/master/todaywine/quiz.json"
        //
        //
        //        guard let encoded  = quizURLString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let _ = URL(string: quizURLString) else {
        //            return
        //        }
        //
        //        guard let hasURL = URL(string: encoded) else {
        //            return
        //        }
        
        let hasURL = URL(string:  "\(API_URL_QUIZ)")!
        
        URLSession.shared.dataTask(with: hasURL) { (data, response, error) in
            
            guard let data = data else {
                let alert = UIAlertController.init(title: "쿼즈 정보가 없음", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.quiz = try decoder.decode([Quiz].self, from: data)
                print("quiz ==> \(self.quiz)")
            } catch {
                print("error ==> \(error)")
            }
            
            DispatchQueue.main.async {
                self.nextQuizData()
            }
        }.resume()
        
    }
    
    private func nextQuizData() {
        let quizIndex = self.userQuizIndex - 1
        self.questionText.text = self.quiz[quizIndex].question
        self.questionText.sizeToFit()
        self.currentAnswer = self.quiz[quizIndex].answer
    }
    
    private func btnToggle() {
        self.answerTrue.isEnabled = self.answerTrue.isEnabled ? false : true
        self.answerFalse.isEnabled = self.answerFalse.isEnabled ? false : true
    }
    
    @IBAction func exit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
