//
//  Common.swift
//  todaywine
//
//  Created by jimmy on 2020/04/03.
//  Copyright © 2020 jimmy. All rights reserved.
//

import Foundation

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
