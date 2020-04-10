//
//  QuizViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class QuizViewController: UIViewControllerBase {
    
    private struct Quiz {
        var question: String
        var answer: Bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quiz = [
            Quiz(question: "Wine maked grape. and, and, and...", answer: true),
            Quiz(question: "notebook is computer.", answer: true),
            Quiz(question: "bon jovi is president.", answer: false),
        ]
        
        let margins = self.view.layoutMarginsGuide
        
        let questionLabel = UILabel(frame: self.view.bounds)
        
        questionLabel.text = quiz[0].question
        questionLabel.font = .boldSystemFont(ofSize: 40)
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        self.view.addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let answerTrue = UILabel(frame: self.view.bounds)
        answerTrue.text = "O"
        answerTrue.font = .boldSystemFont(ofSize: 40)
        answerTrue.textColor = .green
        answerTrue.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(answerTrue)
        
        answerTrue.topAnchor.constraint(equalTo: margins.topAnchor, constant: 200).isActive = true
        answerTrue.widthAnchor.constraint(equalToConstant: 150).isActive = true
        answerTrue.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        answerTrue.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        let answerFalse = UILabel(frame: self.view.bounds)
        answerFalse.text = "X"
        answerFalse.font = .boldSystemFont(ofSize: 40)
        answerFalse.textColor = .red
        answerFalse.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(answerFalse)
        
        let answerTrueMargins = answerTrue.layoutMarginsGuide
        
        answerFalse.topAnchor.constraint(equalTo: margins.topAnchor, constant: 200).isActive = true
        answerFalse.widthAnchor.constraint(equalTo: answerTrueMargins.widthAnchor, constant: 200).isActive = true
        //        answerFalse.leadingAnchor.constraint(greaterThanOrEqualTo: ).isActive = true
        answerFalse.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
    }
}
