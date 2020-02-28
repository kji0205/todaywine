//
//  wine.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//


import Foundation

struct Wine: Codable {
    
    let _id: Int
    let name: String
    let year: String
    let grapes: String
    let country: String
    let region: String
    let description: String
    let picture: String
    
    var info: String {
        return self.name + "(\(self.grapes))" + "(\(self.country))"  + "(\(self.year))"
    }
}
