//
//  DataStore.swift
//  todaywine
//
//  Created by jimmy on 2020/03/23.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    var quizLogs: [QuizLog] = loadQuizLog()
    var searchLogs: [SearchLog] = searchLog()
    
    private static func loadQuizLog() -> [QuizLog] {
        
        do {
            if let data = UserDefaults.standard.data(forKey: "QuizLog"),
                let custom = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [QuizLog] {
                
                return custom
            }
        } catch {
            print(error)
        }
        
        return []
    }
    
    private static func searchLog() -> [SearchLog] {
        
        do {
            if let data = UserDefaults.standard.data(forKey: "SearchLog"),
                let custom = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SearchLog] {
                
                return custom
            }
        } catch {
            print(error)
        }
        
        return []
    }
}
