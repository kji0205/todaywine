//
//  QuizBrain.swift
//  todaywine
//
//  Created by jimmy on 2020/05/27.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

class QuizBrain {
    
    private var quiz: [Quiz] = []
    // 현재 풀고 있는 퀴즈의 순번
    private var quizIndex = 0
    // 풀 수 있는 퀴즈의 수
    private var numberOfQuizUser = 3
    // 현재 퀴즈
    var currentQuiz = ""
    // 현재 퀴즈의 답
    var answerToTheCurrentQuiz = false
    // 현재 퀴즈의 해설
    var currentQuizDescription = ""
    
    init() {
        getQuizData()
        getTheNextQuiz()
    }
    
    // MARK: 퀴즈 정보 로드
    func getQuizData() {
        
        // asset에서 퀴즈데이터 가져옴
        let jsonDecoder = JSONDecoder()
        guard let quizData : NSDataAsset = NSDataAsset(name: "quiz") else {
            return
        }
        do {
            self.quiz = try jsonDecoder.decode([Quiz].self, from: quizData.data)
        } catch {
            print(error.localizedDescription)
        }
        
        // MARK: Call to API - Github
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
        
        // MARK: Call to API - Strapi
        //        let hasURL = URL(string:  "\(API_URL_QUIZ)")!
        //
        //        URLSession.shared.dataTask(with: hasURL) { (data, response, error) in
        //
        //            guard let data = data else {
        //                let alert = UIAlertController.init(title: "쿼즈 정보가 없음", message: nil, preferredStyle: UIAlertController.Style.alert)
        //                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        //                return
        //            }
        //
        //            let decoder = JSONDecoder()
        //
        //            do {
        //                self.quiz = try decoder.decode([Quiz].self, from: data)
        //                print("quiz ==> \(self.quiz)")
        //            } catch {
        //                print("error ==> \(error)")
        //            }
        //
        //            DispatchQueue.main.async {
        //                self.nextQuizData()
        //            }
        //        }.resume()
        
    }
    
    
    // MARK: 퀴즈 정답 확인
    func takeQuiz(userAnswer answer: Bool) -> Bool {
        return answerToTheCurrentQuiz == answer
    }
    
    // MARK: 다음 퀴즈 가져오기
    func getTheNextQuiz() {
        let randomNumber = quiz.count.arc4random
        currentQuiz = quiz[randomNumber].question
        answerToTheCurrentQuiz = quiz[randomNumber].answer
        currentQuizDescription = quiz[randomNumber].description
        quiz.remove(at: randomNumber)
        quizIndex += 1
//        print("getTheNextQuiz : \(quizIndex)")
    }
    
    // MARK: 문제수 체크
    func quizIndexCheck() -> Bool {
        return numberOfQuizUser >= quizIndex
    }
    
    // MARK: 퀴즈를 풀었던 기록 저장
    func saveTheQuizHistory() {
        
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
