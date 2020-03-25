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
        let result = coder.decodeBool(forKey: "result") as! Bool
        
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

class QuizLogDAO {
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("quizLog.archive")
    }()
    
    fileprivate var quizlog: [QuizLog] = [];
    
    func saveItems() {
        let itemsArray = quizlog as NSArray
        print("Saving items to \(fileURL)")
        
//        if !itemsArray.write(to: fileURL, atomically: true) {
//            print("Could not save ")
//        }
        
        do {
            try itemsArray.write(to: fileURL, atomically: true)
        } catch  {
            print(error)
        }
    }
    
    func add(_ item: QuizLog) {
        quizlog.append(item)
        saveItems()
    }
    
    func loadItems() {
        if let itemsArray = NSArray(contentsOf: fileURL) as? [QuizLog] {
            quizlog = itemsArray
            print(quizlog)
        }
        
        do {
            let text = try String(contentsOf: fileURL, encoding: .utf8)
        } catch  {
            print(error)
        }
        
        
        
//        do {
//            try NSArray(contentsOf: fileURL) as? [QuizLog]
////            print(itemsArray)
//        } catch {
//            print(error)
//        }
        
    }
}
