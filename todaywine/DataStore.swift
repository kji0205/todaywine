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
    var quizLogs: [QuizLog] = []
}
