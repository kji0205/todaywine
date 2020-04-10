//
//  wine.swift
//  todaywine
//
//  Created by jimmy on 2020/02/28.
//  Copyright © 2020 jimmy. All rights reserved.
//


import Foundation

struct Wine: Codable {
    
    let id: Int
    let name: String        // 이름
    let nameEng: String     // 영문이름
    let country: String     // 국가
    let region: String?      // 지역
    let wineryName: String  // 와이너리
    let vintage: String     // year
    let type: String?    // red, white, ...
    let grapes: String?  // 품종
    let alcohol: String? // 알콜
    let volume: String?  // 750ml
    let retailPrice: Int    // 소비자가
    let description: String?     // 와인설명
    let image: String?     // 이미지
    let shopName: String   // 매장명
    let shopAddress: String    // 매장주소
    //    let shopAddressLatitude: Float     // 위도
    //    let shopAddressLongitude: Float    // 경도
    
    var info: String {
        return self.name + "(\(self.country))"  + "(\(self.vintage))"
    }
}
