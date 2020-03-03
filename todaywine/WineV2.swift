//
//  WineV2.swift
//  todaywine
//
//  Created by jimmy on 2020/03/03.
//  Copyright © 2020 jimmy. All rights reserved.
//

/**
 "_id": 102,
 "name": "펠 샤도네이",
 "nameEng": "FEL Chardonnay",
 "country": "ANDERSON VALLEY",
 "region": null,
 "wineryName": "CLIFF LEDE VINEYARDS",
 "vintage": "2017",
 "type": null,
 "grapes": null,
 "alcohol": null,
 "volume": null,
 "retailPrice": 0,
 "description": null,
 "image": null,
 "shopName": "고리와인샵",
 "shopAddress": "경기도 성남시 분당구 황새울로 234 분당트라팰리스 110호"
 */
struct WineV2: Codable {
    
    let _id: Int
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
}
