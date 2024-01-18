//
//  Home.swift
//  KTV
//
//  Created by 변상필 on 1/18/24.
//

import Foundation

struct Home: Codable {
    let videos: [Video]
    let rankings: [Ranking]
    let recents: [Recent]
    let recommends: [Recommend]
}

extension Home {
    struct Video: Codable {
        let videoId: Int
        let isHot: Bool
        let title: String
        let subtitle: String
        let imageUrl: URL
        let channel: String
        let channelThumbnailURL: URL
        let channelDescription: String
    }
    
    struct Ranking: Codable {
        let imageUrl: URL
        let videoId: Int
    }
    
    struct Recent: Codable {
        let imageUrl: URL
        let timeStamp: Double
        let title: String
        let channel: String
        // let videoId: Int --> 코드에 빠져있던데 왜 인지 모ㅓ르겠음
    }
    
    struct Recommend: Codable {
        let imageUrl: URL
        let title: String
        let playtime: Double
        let channel: String
        let videoId: Int
    }
}
