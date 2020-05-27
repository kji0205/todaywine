//
//  SearchLog.swift
//  todaywine
//
//  Created by jimmy on 2020/03/30.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

// s
class SearchLog: NSObject, NSCoding, NSSecureCoding, Comparable {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.searchKeyword, forKey: "searchKeyword")
        coder.encode(self.regdate, forKey: "regdate")
        coder.encode(self.result, forKey: "result")
    }
    
    required convenience init?(coder: NSCoder) {
        let searchKeyword = coder.decodeObject(forKey: "searchKeyword") as! String
        let regdate = coder.decodeObject(forKey: "regdate") as! Date
        let result = coder.decodeBool(forKey: "result")
        
        self.init(searchKeyword: searchKeyword, regdate: regdate, result: result)
    }
    
    override init() {
        self.searchKeyword = ""
        self.regdate = Date()
        self.result = false
    }
    
    init(searchKeyword: String, regdate: Date, result: Bool) {
        self.searchKeyword = searchKeyword
        self.regdate = regdate
        self.result = result
    }
    
    var searchKeyword: String
    var regdate: Date
    var result: Bool
    
    static func <(lhs: SearchLog, rhs: SearchLog) -> Bool {
        return lhs.regdate > rhs.regdate
    }
}
