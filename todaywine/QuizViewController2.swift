//
//  QuizViewController2.swift
//  todaywine
//
//  Created by jimmy on 2020/02/23.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class QuizViewController2: UIViewControllerBase {
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerTrue: UIButton!
    @IBOutlet weak var answerFalse: UIButton!
    
    
    var quiz : [Quiz] = []
    var currentAnswer: Bool = false
    
    var store = DataStore.sharedInstance
    
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("quizlog.archive")
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQuizData()
    }
    
    @IBAction func actionTrue(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: currentAnswer ? "정답입니다":"틀렸습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
        
        save(true, currentAnswer)
        
    }
    
    @IBAction func actionFalse(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: currentAnswer ? "틀렸습니다":"정답입니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        save(false, currentAnswer)
    }
    
    // MARK: 퀴즈 기록 저장
    func save(_ result: Bool, _ userAnswer: Bool) {
  
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
    func getQuizData() {
        
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
                let quizIndex = Int.random(in: 0...self.quiz.count-1)
                self.questionText.text = self.quiz[quizIndex].question
                self.questionText.sizeToFit()
                self.currentAnswer = self.quiz[quizIndex].answer
            }
        }.resume()
        
    }
    
}
