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
    @IBOutlet weak var answerTrue: UILabel!
    @IBOutlet weak var answerFalse: UILabel!
    
    struct Quiz {
        var question: String
        var answer: Bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        infoLabel.text = "Quiz"
        infoLabel.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(infoLabel)
        

        let quiz = [
            Quiz(question: "Wine maked grape. and, and, and...", answer: true),
            Quiz(question: "notebook is computer.", answer: true),
            Quiz(question: "bon jovi is president.", answer: false),
        ]
        
        questionText?.text = quiz[0].question
    }
    
}
