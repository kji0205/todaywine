//
//  Common.swift
//  todaywine
//
//  Created by jimmy on 2020/04/03.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

let API_URL: String = "http://45.77.251.183:1337"
let API_URL_WINE: String = API_URL + "/wines"
let API_URL_QUIZ: String = API_URL + "/quizzes"

extension Dictionary {
    var queryString: String {
        var output = ""
        for (key, value) in self {
            output = output + "\(key)=\(value)&"
        }
        
        output = String(output.dropLast())
        return output
    }
}
