//
//  QuizLog.swift
//  todaywine
//
//  Created by jimmy on 2020/03/21.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

class QuizData: Codable {
    init() {
        self.regdate = Date()
        self.result = false
    }
    
    init(idx: Int, regdate: Date, result: Bool) {
        self.regdate = regdate
        self.result = result
    }
    
    var idx: Int?
    var regdate: Date
    var result: Bool
}

class QuizLog: NSObject, NSCoding, NSSecureCoding, Comparable {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.idx, forKey: "idx")
        coder.encode(self.regdate, forKey: "regdate")
        coder.encode(self.result, forKey: "result")
    }
    
    required convenience init?(coder: NSCoder) {
        let idx = coder.decodeInteger(forKey: "idx")
        let regdate = coder.decodeObject(forKey: "regdate") as! Date
        let result = coder.decodeBool(forKey: "result")
        
        self.init(idx: idx, regdate: regdate, result: result)
    }
    
    override init() {
        self.idx = 0
        self.regdate = Date()
        self.result = false
    }
    
    init(idx: Int, regdate: Date, result: Bool) {
        self.idx = idx
        self.regdate = regdate
        self.result = result
    }
    
    var idx: Int
    var regdate: Date
    var result: Bool
    
    static func <(lhs: QuizLog, rhs: QuizLog) -> Bool {
        return lhs.regdate > rhs.regdate
    }
}
