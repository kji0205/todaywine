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
        

        let jsonDecoder = JSONDecoder()
        guard let quizData : NSDataAsset = NSDataAsset(name: "quiz") else {
            return
        }
        do {
            self.quiz = try jsonDecoder.decode([Quiz].self, from: quizData.data)
        } catch {
            print(error.localizedDescription)
        }
        
        let quizIndex = Int.random(in: 0...quiz.count-1)
        questionText.text = quiz[quizIndex].question
        questionText.sizeToFit()
        currentAnswer = quiz[quizIndex].answer
        
        
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
    
    
    func save(_ result: Bool, _ userAnswer: Bool) {
  
        let _quizLog = QuizLog.init(idx: 1, regdate: Date(), result: (result==userAnswer))

        self.store.quizLogs.append(_quizLog)
        
        do {
            try NSKeyedArchiver.archivedData(withRootObject: self.store.quizLogs, requiringSecureCoding: false)
        } catch  {
            print(error)
        }
        
    }
    
    
    func loadQuizLog() {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.store.quizLogs, requiringSecureCoding: false)
            
            if let ourData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [QuizLog] {
                self.store.quizLogs = ourData
            }
        } catch  {
            print(error)
        }
        
    }
}
