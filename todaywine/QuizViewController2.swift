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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let infoLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
//        infoLabel.text = "Quiz"
//        infoLabel.font = .boldSystemFont(ofSize: 20)
//        
//        self.view.addSubview(infoLabel)
        

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
        currentAnswer = quiz[quizIndex].answer
        
    }
    
    @IBAction func actionTrue(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: currentAnswer ? "정답입니다":"틀렸습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionFalse(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: currentAnswer ? "틀렸습니다":"정답입니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
