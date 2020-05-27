//
//  Quiz.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

struct Quiz: Codable {
    
    let id: Int
    let grade: String
    let question: String
    let answer: Bool
    let description: String
//    let created_at: String
//    let updated_at: String
}
